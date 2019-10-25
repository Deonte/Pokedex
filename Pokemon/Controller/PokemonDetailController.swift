//
//  PokemonDetailController.swift
//  Pokemon
//
//  Created by Deonte on 10/18/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PokemonDetailController: UIViewController {
   
    var selectedPokemon: Pokemon?
    var pdView = PokemonDetailView()
    
    override func loadView() {
        super.loadView()
        view = pdView
        pdView.selectedPokemon = selectedPokemon
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let vc = PokemonController()
        vc.tableView.reloadData().self
        
        print("Dissapearing")
    }
    
   
}
