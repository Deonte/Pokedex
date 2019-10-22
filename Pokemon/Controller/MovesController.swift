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

var didGetMoves = false

class MovesController: UITableViewController, UISearchBarDelegate {
    
    //MARK:- Instance Variables
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 696)
    fileprivate let limit = 30
    fileprivate lazy var randomMoveURL = "https://pokeapi.co/api/v2/move/?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var moves = [Move]()
    fileprivate var urls = [String]()
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        checkMoves()
    }
    
    fileprivate func checkMoves() {
         if didGetMoves == false {
             getMovesData(url: randomMoveURL)
             didGetMoves = true
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
          //let pokeURL = "https://pokeapi.co/api/v2/move/\(searchText.lowercased())/"
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
        moves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: moveCellID, for: indexPath) as! MoveCell
        
        let moves  = self.moves[indexPath.row]
        cell.moves = moves
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoveDetailController()
        vc.selectedMove = moves[indexPath.row]
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK:- Networking
    
    fileprivate func getMovesData(url: String) {
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let allMoves: JSON = JSON(response.result.value!)
                self.getMoveURLS(json: allMoves)
          
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    fileprivate func getSearchedPokemonData(url: String) {
        
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
            getSearchedPokemonData(url: urls[i])
        }
        
    }
    
}


