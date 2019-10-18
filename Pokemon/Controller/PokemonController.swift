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
    fileprivate let searchControlller = UISearchController(searchResultsController: nil)
    fileprivate let randomNumber = Int.random(in: 0 ..< 914)
    fileprivate lazy var randomPokemonURL = "https://pokeapi.co/api/v2/pokemon?offset=\(randomNumber / 2)&limit=50"
    
    fileprivate var pokemon = [Pokemon]()
    fileprivate var urls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
        setupTableView()
        setupSearchController()
        getPokemonData(url: randomPokemonURL)
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
        
        //        cell.spriteImageView.image = #imageLiteral(resourceName: "pokemonImage")
        //        cell.pokemonNameLabel.text = pokemon.name
        //        cell.pokedexNumberLabel.text = pokemon.id.format(pattern: "#%03d") //String(format: "#%03d", [pokemon.id]) //"#\(pokemon.id)"
        //        cell.primaryTypeImageView.image = #imageLiteral(resourceName: "smallWater")
        //        cell.secondaryTypeImageView.image = #imageLiteral(resourceName: "smallWater")
        
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
                self.updatePokemonData(json: pokemon)
                
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
        
        // print(pokemon.description)
        //
        //        guard let name = pokemonName.string?.capitalized else { return }
        //        guard let id = pokemonID.int else { return }
        //        guard let sprite = pokemonSprite.string else { return }
        //        guard let type = pokemonPrimaryType.string else { return }
        //        guard let secondaryType = pokemonSecondaryType.string else { return }
        //        let typeImage = getTypeImage(type: type)
        //
        //pokemon.append(Pokemon(name: name, id: id, sprite: sprite, primaryType: type, primaryTypeImage: typeImage, secondaryType: secondaryType))
        //
        //        pokemon.append(Pokemon(name: pokemonName.string?.capitalized ?? "", id: pokemonID.int ?? 0, sprite: pokemonSprite.string ?? "", primaryType: pokemonPrimaryType.string ?? "", primaryTypeImage: typeImage, secondaryType: pokemonSecondaryType.string ?? ""))
        //
        //print(pokemon.count)
        
        //print(pokemon)
        //print("Pokemon name is: \(pokemonName.string?.capitalized ?? "")\nIt is a \(pokemonPrimaryType) type pokemon.\nAnd one of it's special abilities is: \(pokemonSpecialMove).\nSprite: \(pokemonSprite)\nNumber: \(pokemonID)")
    }
    
    fileprivate func updatePokemonData(json : JSON) {
        
        for i in 0...49 {
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
            getSearchedPokemonData(url: urls[i])
        }
        
        pokemonHud.dismiss()
        
    }
    
}







