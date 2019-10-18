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
            
            let secondary = pokemon.secondaryType
            DispatchQueue.main.async {
                if secondary.isEmpty == false {
                    self.primaryTypeImageView.isHidden = false
                    self.secondaryTypeImageView.isHidden = false
                    self.primaryTypeImageView.image = self.pokemon.secondaryTypeImage
                    self.secondaryTypeImageView.image = self.pokemon.primaryTypeImage
                } else if secondary.isEmpty == true {
                    self.primaryTypeImageView.isHidden = false
                    self.primaryTypeImageView.image = self.pokemon.primaryTypeImage
                }
            }
        }
    }
    
}
