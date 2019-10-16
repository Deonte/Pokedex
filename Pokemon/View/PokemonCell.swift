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
            if let url = URL(string: sprite) {
                spriteImageView.sd_setImage(with: url, completed: nil)
            }
            
           // guard let url = URL(string: sprite) else { return }
            
//            URLSession.shared.dataTask(with: url) { (data, _, _) in
//                print("Finished downloding image data:", data)
//                imageView?.sd_setImage(with: url, completed: nil)
//            }.resume()
//
            pokemonNameLabel.text = pokemon.name
            pokedexNumberLabel.text = pokemon.id.format(pattern: "#%03d")
        }
    }

}
