//
//  ItemsController.swift
//  Pokemon
//
//  Created by Deonte on 10/13/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

var didRetrieveItems = false

class ItemsController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
      lazy var searchFooterBottomConstraint = tabBarController?.tabBar.frame.minY
      
      var keyboardHeightVar: CGFloat! {
          didSet {
              searchFooter.frame = CGRect(x: 0, y: (searchFooterBottomConstraint ?? 0) - self.keyboardHeightVar, width: screenWidth, height: 44)
          }
      }
    
      fileprivate var searchFooter: SearchFooter  = {
          let view = SearchFooter()
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
      }()
    
    //MARK:- Instance Variables
    
    fileprivate let itemHud = JGProgressHUD(style: .dark)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 914)
    fileprivate let limit = 954
    fileprivate lazy var randomItemURL = "https://pokeapi.co/api/v2/item?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var items = [Item]()
    fileprivate var filteredItems: [Item] = []
    fileprivate var urls = [String]()
    
    //MARK:- View Life Cycle
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupTableView()
        setupSearchController()
        checkItemData()
        setupNotifications()
    }
    
    override func viewDidLayoutSubviews() {
           setupFooter()
       }

       override func updateViewConstraints() {
           super.updateViewConstraints()
             keyboardHeightVar = 0
             searchFooter.frame = CGRect(x: 0, y: searchFooterBottomConstraint! - self.keyboardHeightVar, width: screenWidth, height: 44)
       }
       
       fileprivate func setupFooter() {
              navigationController?.view.addSubview(searchFooter)
          }
    //MARK: - Helper Functions
       
    fileprivate func checkItemData() {
        if didRetrieveItems == false {
            getItemData(url: randomItemURL)
            didRetrieveItems = true
        } else {
            return
        }
    }
    
    fileprivate func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
            
        }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
    }
    
     func handleKeyboard(notification: Notification) {
         // 1
         guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
             keyboardHeightVar = 0
             view.layoutIfNeeded()
             return
         }
         
         guard let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

         // 2
         let originYval = keyboardFrame.cgRectValue.origin.y
         let keyboardHeight = keyboardFrame.cgRectValue.size.height
         UIView.animate(withDuration: 0.1, animations: { () -> Void in
             self.keyboardHeightVar = keyboardHeight
             self.searchFooter.frame = CGRect(x: 0, y: originYval - 44, width: 414, height: 44)
             
             self.view.layoutIfNeeded()
         })
     }
    
    
    
    //MARK:- Setup Search
    
    fileprivate func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Items"
        searchController.searchResultsUpdater = self
    }
    
   func updateSearchResults(for searchController: UISearchController) {
          let searchBar = searchController.searchBar
                 filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredItems = items.filter { (items) -> Bool in
            return items.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK:- Setup TableView
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredItems.count, of: items.count)
            return filteredItems.count
        }
        searchFooter.setNotFiltering()
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellID, for: indexPath) as! ItemCell
        
        let items: Item
        
        if isFiltering {
            items = filteredItems[indexPath.row]
        } else {
            items = self.items[indexPath.row]
        }
        
        cell.items = items
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailController()
        if isFiltering {
            vc.selectedItem = filteredItems[indexPath.row]
        } else {
            vc.selectedItem = items[indexPath.row]
            
        }
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Networking
    
    fileprivate func getItemData(url: String) {
        
        itemHud.textLabel.text = "Finding Items"
        itemHud.show(in: navigationController?.view ?? view)
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let item : JSON = JSON(response.result.value!)
                self.getItemURLS(json: item)
                self.itemHud.dismiss()
                
            } else {
                self.itemHud.textLabel.text = String(describing: response.result.error?.localizedDescription)
                self.itemHud.dismiss(afterDelay: 3)
            }
        }
    }
    
    fileprivate func getItemsFromArrayOf(url: String) {
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let item : JSON = JSON(response.result.value!)
                self.updateSearchedItemData(json: item)
                self.tableView.reloadData()
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }

    //MARK: - JSON Parsing
    
    fileprivate func updateSearchedItemData(json : JSON) {
        
        let name        = json["name"]
        let price       = json["cost"]
        let description = json["effect_entries"][0]["effect"]
        let sprite      = json["sprites"]["default"]
        DispatchQueue.main.async {
            self.items.append(Item(sprite: sprite.string ?? "", name: name.string?.capitalized.replacingOccurrences(of: "-", with: " ") ?? "", price: price.int ?? 0, description: description.string ?? ""))
        }
    }
    
    fileprivate func getItemURLS(json : JSON) {
        
        for i in 0...limit - 1{
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getItemsFromArrayOf(url: urls[i])
        }
    }
    
}
