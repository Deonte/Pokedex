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
import JGProgressHUD

class PokemonController: UITableViewController, UISearchBarDelegate {
    
    //MARK:- Instance Variables
    
    fileprivate let pokemonHud = JGProgressHUD(style: .dark)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = Int.random(in: 0 ..< 914)
    fileprivate let limit = 50
    fileprivate lazy var randomPokemonURL = "https://pokeapi.co/api/v2/pokemon?offset=\(randomOffset / 2)&limit=\(limit)"
    
    fileprivate var pokemon = [Pokemon]()
    fileprivate var urls = [String]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupTableView()
        setupSearchController()
        getPokemonData(url: randomPokemonURL)
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
        
        let pokeURL = "https://pokeapi.co/api/v2/pokemon/\(searchText.lowercased())/"
        getPokemonData(url: pokeURL)
        
    }
    
    //MARK:- Setup TableView
    
    fileprivate func setupTableView() {
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
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetailController()
        vc.selectedPokemon = pokemon[indexPath.row]
        navigationController?.present(vc, animated: true, completion: nil)        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Networking
    
    fileprivate func getPokemonData(url: String) {
        
        pokemonHud.textLabel.text = "Catching Pokemon"
        pokemonHud.show(in: view)
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let pokemon : JSON = JSON(response.result.value!)
                self.getPokemonURLS(json: pokemon)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.pokemonHud.textLabel.text = String(describing: response.result.error)
            }
        }
    }
    
    fileprivate func getSearchedPokemonData(url: String) {
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let pokemon : JSON = JSON(response.result.value!)
                self.updateSearchedPokemonData(json: pokemon)
                self.tableView.reloadData()
                
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
        
    }

    //MARK: - JSON Parsing
    
    fileprivate func updateSearchedPokemonData(json : JSON) {
        
        let pokemonName = json["name"]
        let pokemonPrimaryType = json["types"][0]["type"]["name"]
        let pokemonSecondaryType = json["types"][1]["type"]["name"]
        let pokemonID = json["id"]
        let pokemonSprite = json["sprites"]["front_default"]
        //let pokemonSpecialMove = json["abilities"][0]["ability"]["name"]
       
        pokemon.append(Pokemon(name: pokemonName.string?.capitalized ?? "", id: pokemonID.int ?? 0, sprite: pokemonSprite.string ?? "", primaryType: pokemonPrimaryType.string ?? "", secondaryType: pokemonSecondaryType.string ?? ""))
     
    }
    
    fileprivate func getPokemonURLS(json : JSON) {
        
        for i in 0...49 {
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getSearchedPokemonData(url: urls[i])
        }
        
        pokemonHud.dismiss()
        
    }
    
}







