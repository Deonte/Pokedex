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

var didGetItems = false

class ItemsController: UITableViewController, UISearchBarDelegate {
    
    //MARK:- Instance Variables
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 914)
    fileprivate let limit = 180
    fileprivate lazy var randomItemURL = "https://pokeapi.co/api/v2/item?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var items = [Item]()
    fileprivate var urls = [String]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupTableView()
        setupSearchController()
        checkItemData()
        
    }
    
    fileprivate func checkItemData() {
        if didGetItems == false {
            getItemData(url: randomItemURL)
            didGetItems = true
        } else {
            return
        }
    }
    
    //MARK:- Setup Search
    
    fileprivate func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let itemURL = "https://pokeapi.co/api/v2/item/\(searchText.lowercased())/"
        print(itemURL)
    }
    
    //MARK:- Setup TableView
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellID, for: indexPath) as! ItemCell
        
        let items = self.items[indexPath.row]
        cell.items = items
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailController()
        vc.selectedItem = items[indexPath.row]
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Networking
    
    fileprivate func getItemData(url: String) {
        
        print("GET ITEM DATA FUNCTION CALLED")
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let item : JSON = JSON(response.result.value!)
                self.getItemURLS(json: item)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
        
    }
    
    fileprivate func getSearchedItemData(url: String) {
        
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
        
        items.append(Item(sprite: sprite.string ?? "", name: name.string?.capitalized.replacingOccurrences(of: "-", with: " ") ?? "", price: price.int ?? 0, description: description.string ?? ""))
    }
    
    fileprivate func getItemURLS(json : JSON) {
        
        for i in 0...limit - 1{
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getSearchedItemData(url: urls[i])
        }
    }
    
}
