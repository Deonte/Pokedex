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
import SDWebImage

var didYouGetPokemon = false

class PokemonController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    //MARK:- Instance Variables
    lazy var searchFooterBottomConstraint = tabBarController?.tabBar.frame.minY//tabBarController?.tabBar.frame.origin.y ?? 0
    
    var keyboardHeightVar: CGFloat! {
        didSet {
            searchFooter.frame = CGRect(x: 0, y: (searchFooterBottomConstraint ?? 0) - self.keyboardHeightVar, width: 414, height: 44)
        }
    }
  
    fileprivate var searchFooter: SearchFooter  = {
        let view = SearchFooter()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    fileprivate let pokemonHud = JGProgressHUD(style: .dark)
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let randomOffset = 0 //Int.random(in: 0 ..< 914)
    fileprivate let limit = 750
    fileprivate lazy var randomPokemonURL = "https://pokeapi.co/api/v2/pokemon?offset=\(randomOffset)&limit=\(limit)"
    
    fileprivate var pokemon = [Pokemon]()
    fileprivate var urls = [String]()
    fileprivate var filteredPokemon: [Pokemon] = []
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor
    
        setupTableView()
        setupSearchController()
        checkPokemonData()
        setupNotifications()
        
    }
    
    override func viewDidLayoutSubviews() {
        setupFooter()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
          keyboardHeightVar = 0
          searchFooter.frame = CGRect(x: 0, y: searchFooterBottomConstraint! - self.keyboardHeightVar, width: 414, height: 44)
    }

    fileprivate func setupFooter() {
        navigationController?.view.addSubview(searchFooter)
    }
    
    //MARK:- Helper Functions
    
    fileprivate func checkPokemonData() {
        if didYouGetPokemon == false {
            getPokemonData(url: randomPokemonURL)
            didYouGetPokemon = true
        } else {
            return
        }
    }
    
    fileprivate func addPokemonObjects(_ pokemonName: JSON, _ pokemonID: JSON, _ pokemonSprite: JSON, _ pokemonPrimaryType: JSON, _ pokemonSecondaryType: JSON, _ speciesURL: JSON) {
         pokemon.append(Pokemon(name: pokemonName.string?.capitalized ?? "", id: pokemonID.int ?? 0, sprite: pokemonSprite.string ?? "", primaryType: pokemonPrimaryType.string ?? "", secondaryType: pokemonSecondaryType.string ?? "", flavorText: speciesURL.string ?? "Unknown."))
     }
     
    fileprivate func sortPokemon(pokemon: [Pokemon]) {
          let sortedPokemon = pokemon.sorted { (id0, id1 ) -> Bool in
              return id0.id < id1.id
          }
          self.pokemon = sortedPokemon
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
            print("Keyboard will change")
            view.layoutIfNeeded()
            return
        }
        
        guard let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        // 2
        let originYval = keyboardFrame.cgRectValue.origin.y
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.keyboardHeightVar = keyboardHeight
            self.searchFooter.frame = CGRect(x: 0, y: originYval - 44/*self.searchFooterBottomConstraint! - self.keyboardHeightVar*/, width: 414, height: 44)
            
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK:- Setup Search
    
    fileprivate func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
     
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Pokemon"
        definesPresentationContext = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredPokemon = pokemon.filter { (pokemon) -> Bool in
            return pokemon.name.lowercased().contains(searchText.lowercased())
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
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: pokemonCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredPokemon.count, of: pokemon.count)
            return filteredPokemon.count
        }
        searchFooter.setNotFiltering()
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokemonCellID, for: indexPath) as! PokemonCell

        let pokemon: Pokemon
        
        if isFiltering {
            pokemon = filteredPokemon[indexPath.row]
        } else {
            pokemon = self.pokemon[indexPath.row]
        }
        
        cell.pokemon = pokemon
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetailController()
        if isFiltering {
            vc.selectedPokemon = filteredPokemon[indexPath.row]
        } else {
            vc.selectedPokemon = pokemon[indexPath.row]
        }
        
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
        
        DispatchQueue.main.async {
            Alamofire.request(url, method: .get ).responseJSON { response in
                if response.result.isSuccess {
                    
                    let pokemon : JSON = JSON(response.result.value!)
                    self.getPokemonURLS(json: pokemon)
                    self.pokemonHud.dismiss(afterDelay: 3)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.pokemonHud.textLabel.text = String(describing: response.result.error)
                    self.pokemonHud.dismiss(afterDelay: 3)
                }
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
        

        addPokemonObjects(pokemonName, pokemonID, pokemonSprite, pokemonPrimaryType, pokemonSecondaryType, speciesURL)
        sortPokemon(pokemon: pokemon)
        
        
    }
    
    fileprivate func getPokemonURLS(json : JSON) {
        for i in 0...limit - 1{
            let result = json["results"][i]["url"]
            urls.append(result.string ?? "")
        }
        
        urls.forEach { (url) in
            getSearchedPokemonData(url: url)
        }
    }
    
}
