//
//  MoveCell.swift
//  Pokemon
//
//  Created by Deonte on 10/19/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class MoveCell: UITableViewCell {

    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveTypeImageView: UIImageView!
    
    
    var moves: Move! {
        didSet {
            moveNameLabel.text = moves.name
            moveTypeImageView.image = getTypeImage(type: moves.type)
        }
    }
}
