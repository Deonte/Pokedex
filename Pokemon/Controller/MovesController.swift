//
//  MovesController.swift
//  Pokemon
//
//  Created by Deonte on 10/13/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

var didRetrieveMoves = false

class MovesController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
   
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
    
    fileprivate let moveHud = JGProgressHUD(style: .dark)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 696)
    fileprivate let limit = 746
    fileprivate lazy var randomMoveURL = "https://pokeapi.co/api/v2/move/?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var moves = [Move]()
    fileprivate var filteredMoves: [Move] = []
    fileprivate var urls = [String]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        checkMoves()
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
    
    fileprivate func checkMoves() {
         if didRetrieveMoves == false {
             getMovesData(url: randomMoveURL)
             didRetrieveMoves = true
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
        searchController.searchBar.placeholder = "Search Moves"
        searchController.searchResultsUpdater = self
    }
   
    
    func updateSearchResults(for searchController: UISearchController) {
           let searchBar = searchController.searchBar
                  filterContentForSearchText(searchBar.text!)
       }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredMoves = moves.filter { (moves) -> Bool in
            return moves.name.lowercased().contains(searchText.lowercased())
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
        let nib = UINib(nibName: "MoveCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: moveCellID)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredMoves.count, of: moves.count)
            return filteredMoves.count
        }
        searchFooter.setNotFiltering()
        return moves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: moveCellID, for: indexPath) as! MoveCell
        
        let moves: Move
        
        if isFiltering {
            moves = filteredMoves[indexPath.row]
        } else {
            moves = self.moves[indexPath.row]
        }
        
        cell.moves = moves

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoveDetailController()
        if isFiltering {
            vc.selectedMove = filteredMoves[indexPath.row]
        } else {
            vc.selectedMove = moves[indexPath.row]
        }
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK:- Networking
    
    fileprivate func getMovesData(url: String) {
        
        moveHud.textLabel.text = "Finding Moves"
        moveHud.show(in: navigationController?.view ?? view)
        
        DispatchQueue.main.async {
            Alamofire.request(url, method: .get ).responseJSON { response in
                if response.result.isSuccess {
                    
                    let allMoves: JSON = JSON(response.result.value!)
                    self.getMoveURLS(json: allMoves)
                    self.moveHud.dismiss()
                } else {
                    self.moveHud.textLabel.text = String(describing: response.result.error?.localizedDescription)
                    self.moveHud.dismiss(afterDelay: 3)
                }
            }
        }
        
    }
    
    fileprivate func getMoveDataFrom(url: String) {
        DispatchQueue.main.async {
            Alamofire.request(url, method: .get ).responseJSON { response in
                if response.result.isSuccess {
                    
                    let moves: JSON = JSON(response.result.value!)
                    self.updateMovesList(json: moves)
                    self.tableView.reloadData()

                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
            }
        }
        
        
    }
 
    //MARK:- JSON Parsing
    
    fileprivate func updateMovesList(json : JSON) {
        
        let name         = json["name"]
        let type         = json["type"]["name"]
        let basePower    = json["power"]
        let id           = json["id"]
        let accuracy     = json["accuracy"]
        let pp           = json["pp"]
        let effect       = json["effect_entries"][0]["effect"]
        let effectChance = json["effect_chance"]
  
        moves.append(Move(name: name.string?.capitalized.replacingOccurrences(of: "-", with: " ") ?? "", type: type.string ?? "", basePower: basePower.int ?? 0, id: id.int ?? 0, accuracy: accuracy.int ?? 0, pp: pp.int ?? 0, effect: effect.string ?? "", effectChance: effectChance.int ?? 0))
  
    }
    
    fileprivate func getMoveURLS(json : JSON) {
        
        for i in 0...limit - 1 {
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getMoveDataFrom(url: urls[i])
        }
        
    }
    
}


