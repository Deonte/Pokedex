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

var didYouGetPokemon = false

class PokemonController: UITableViewController, UISearchBarDelegate {
    
    //MARK:- Instance Variables
    
//    class ProgressView: UIViewController {
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = .clear
//        }
//    }
    
    fileprivate let pokemonHud = JGProgressHUD(style: .dark)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 914)
    fileprivate let limit = 150
    fileprivate lazy var randomPokemonURL = "https://pokeapi.co/api/v2/pokemon?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var pokemon = [Pokemon]()
    fileprivate var urls = [String]()
    fileprivate var filteredPokemon = [Pokemon]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
     
//        print("Show registration Page")
//        let pV = ProgressView()
//        pV.modalPresentationStyle = .fullScreen
//        present(pV, animated: true)
//

        setupTableView()
        setupSearchController()
        checkPokemonData()

    }
    
    fileprivate func checkPokemonData() {
        if didYouGetPokemon == false {
            getPokemonData(url: randomPokemonURL)
            didYouGetPokemon = true
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
        
        //let pokeURL = "https://pokeapi.co/api/v2/pokemon/\(searchText.lowercased())/"
        
        pokemon.forEach { (pokemon) in
            
            if pokemon.name.contains(searchText.lowercased()) == true {
                print("Its true!")
                filteredPokemon.append(pokemon)
                filteredPokemon.forEach { (pokemon) in
                    print(pokemon.name)
                }
            } else if searchText.isEmpty || searchText == "" {
                filteredPokemon.removeAll()
                print(filteredPokemon.isEmpty)
            }
        }
        
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
        
        print("GET POKEMON DATA FUNCTION CALLED")
        pokemonHud.textLabel.text = "Catching Pokemon"
        pokemonHud.show(in: navigationController?.view ?? view)
        
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                
                let pokemon : JSON = JSON(response.result.value!)
                self.getPokemonURLS(json: pokemon)
                self.pokemonHud.dismiss()
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.pokemonHud.textLabel.text = String(describing: response.result.error)
                self.pokemonHud.dismiss(afterDelay: 3)
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
        let speciesURL = json["species"]["url"]
        let flavorText = updateSpeciesData(url: speciesURL.string!)
        
        pokemon.append(Pokemon(name: pokemonName.string?.capitalized ?? "", id: pokemonID.int ?? 0, sprite: pokemonSprite.string ?? "", primaryType: pokemonPrimaryType.string ?? "", secondaryType: pokemonSecondaryType.string ?? "", flavorText: flavorText))
    }
    
    fileprivate func updateSpeciesData(url: String) -> String{
        var flavorText = ""
        Alamofire.request(url, method: .get ).responseJSON { response in
            if response.result.isSuccess {
                let pokemonSpecies : JSON = JSON(response.result.value!)
                let text = pokemonSpecies["flavor_text_entries"][1]["flavor_text"]
                let name = pokemonSpecies["name"]
                flavorText = text.string ?? ""
                print("Name:\(name.string ?? "")\nFlavor Text:\(flavorText)\n")
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
        
        return flavorText
    }
    
    fileprivate func parseSpecies(json: JSON) -> String {
        let flavorText = json["flavor_text_entries"][1]["flavor_text"]
        return flavorText.string!
    }
    
    fileprivate func getPokemonURLS(json : JSON) {
        for i in 0...limit - 1{
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getSearchedPokemonData(url: urls[i])
        }
    }
    
}







