//
//  PokemonController.swift
//  Pokemon
//
//  Created by Deonte on 10/10/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PokemonController: UITableViewController, UISearchBarDelegate {
    
    //Implement search controller
    let searchControlller = UISearchController(searchResultsController: nil)
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    var pokemon = [
        Pokemon(name: "Squirtle", id: 7, sprite: "", type: "Water"),
        Pokemon(name: "Pikachu", id: 25, sprite: "", type: "Electric")
    ]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupTableView()
        setupSearchController()
    }
    
    //MARK:- Setup Search
    
    fileprivate func setupSearchController() {
        navigationItem.searchController = searchControlller
        navigationItem.hidesSearchBarWhenScrolling = false
        searchControlller.obscuresBackgroundDuringPresentation = false
        searchControlller.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // Implement Alomofire to search Pokemon API
        
        let pokeURL = "https://pokeapi.co/api/v2/pokemon/\(searchText.lowercased())/"
        
        getPokemonData(url: pokeURL)
        
    }
    
    //MARK:- Setup TableView
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let pokemon = self.pokemon[indexPath.row]
        cell.textLabel?.text = "\(pokemon.name)\n#\(pokemon.id) Type: \(pokemon.type)"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "pokemonImage")
        
        return cell
    }
    
    //MARK: - Networking
    
    func getPokemonData(url: String) {
        
        Alamofire.request(url, method: .get )
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Found Pokemon")
                    let pokemon : JSON = JSON(response.result.value!)
                    self.updatePokemonData(json: pokemon)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
        
    }
    
    
    //MARK: - JSON Parsing
    
    func updatePokemonData(json : JSON) {
    
        let pokemonName = json["name"]
        let pokemonType = json["types"][0]["type"]["name"]
        let pokemonSpecialMove = json["abilities"][0]["ability"]["name"]
        
        print("Pokemon name is: \(pokemonName.string?.capitalized ?? "")\nIt is a \(pokemonType) type pokemon.\nAnd one of it's special abilities is: \(pokemonSpecialMove).")
        
    }
    
    
}






