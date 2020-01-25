//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Deonte on 10/16/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokedexNumberLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView! 
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    
    var pokemon: Pokemon! {
        didSet {
            
            let sprite = pokemon.sprite
            guard let url = URL(string: sprite) else { return }

            DispatchQueue.main.async {
                self.spriteImageView.sd_setImage(with: url, completed: nil)
            }
           
            pokemonNameLabel.text = pokemon.name
            pokedexNumberLabel.text = pokemon.id.format(pattern: "#%03d")
          
            if pokemon.secondaryType.isEmpty {
                primaryTypeImageView.isHidden = false
                primaryTypeImageView.image = getTypeImage(type: pokemon.primaryType )
            } else {
                primaryTypeImageView.isHidden = false
                secondaryTypeImageView.isHidden = false
                primaryTypeImageView.image = getTypeImage(type: pokemon.secondaryType )
                secondaryTypeImageView.image = getTypeImage(type: pokemon.primaryType )
            }
        }
    }
    
}
