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
    
    var pokemon = [Pokemon]()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .mainBackgroundColor
        setupTableView()
        setupSearchController()
        getPokemonData(url: baseURL)
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
        //tableView.register(PokemonCell.self, forCellReuseIdentifier: pokemonCellID)
        
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: pokemonCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCellID, for: indexPath) as! PokemonCell
       
        let pokemon = self.pokemon[indexPath.row]
        cell.pokemon = pokemon
        
//        cell.spriteImageView.image = #imageLiteral(resourceName: "pokemonImage")
//        cell.pokemonNameLabel.text = pokemon.name
//        cell.pokedexNumberLabel.text = pokemon.id.format(pattern: "#%03d") //String(format: "#%03d", [pokemon.id]) //"#\(pokemon.id)"
//        cell.primaryTypeImageView.image = #imageLiteral(resourceName: "smallWater")
//        cell.secondaryTypeImageView.image = #imageLiteral(resourceName: "smallWater")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //MARK: - Networking
    
    func getPokemonData(url: String) {
        
        Alamofire.request(url, method: .get ).responseJSON { response in
                if response.result.isSuccess {
                    
                    //print("Sucess! Found Pokemon")
                    let pokemon : JSON = JSON(response.result.value!)
                    self.updatePokemonData(json: pokemon)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
        
    }
    
    func getSearchedPokemonData(url: String) {
        
        Alamofire.request(url, method: .get ).responseJSON { response in
                if response.result.isSuccess {
                    
                    //print("Sucess! Found Pokemon")
                    let pokemon : JSON = JSON(response.result.value!)
                    self.updateSearchedPokemonData(json: pokemon)
                    self.tableView.reloadData()
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
        
    }
    
    
    
    //MARK: - JSON Parsing
    
    func updateSearchedPokemonData(json : JSON) {
    
        let pokemonName = json["name"]
        let pokemonPrimaryType = json["types"][0]["type"]["name"]
        let pokemonID = json["id"]
        let pokemonSprite = json["sprites"]["front_default"]
        let pokemonSpecialMove = json["abilities"][0]["ability"]["name"]
        
        pokemon.append(Pokemon(name: pokemonName.string?.capitalized ?? "", id: pokemonID.int ?? 0, sprite: pokemonSprite.string ?? "", primaryType: pokemonPrimaryType.string ?? ""))
        
        print(pokemon.count)
        
        //print(pokemon)
        //print("Pokemon name is: \(pokemonName.string?.capitalized ?? "")\nIt is a \(pokemonPrimaryType) type pokemon.\nAnd one of it's special abilities is: \(pokemonSpecialMove).\nSprite: \(pokemonSprite)\nNumber: \(pokemonID)")
    }
    
    fileprivate var urls = [String]()
    
    func updatePokemonData(json : JSON) {
        
        let totalResults = json["count"]
        
        print("It's \(totalResults) pokemon.")
        
        for i in 0...19 {
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            
            getSearchedPokemonData(url: urls[i])
        }
        
       
        
      }

}






