//
//  ItemCell.swift
//  Pokemon
//
//  Created by Deonte on 10/22/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemSpriteImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    var items: Item! {
        didSet {
            let sprite = items.sprite
            guard let url = URL(string: sprite) else { return }
            
            DispatchQueue.main.async {
                self.itemSpriteImageView.sd_setImage(with: url, completed: nil)
            }
            
            itemNameLabel.text = items.name.replacingOccurrences(of: "-", with: " ")
            itemPriceLabel.text = "\(items.price)"
        }
    }
}
