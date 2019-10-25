//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Deonte on 10/18/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class PokemonDetailView: UIView {
    
    
    var selectedPokemon: Pokemon! {
        didSet {
            
            let sprite = selectedPokemon.sprite
            guard let url = URL(string: sprite) else { return }
            
            DispatchQueue.main.async {
                self.spriteImageView.sd_setImage(with: url, completed: nil)
            }
            
            nameLabel.text = selectedPokemon.name
            descriptionTextView.text = selectedPokemon.flavorText
            if selectedPokemon.secondaryType == "" {
                primaryTypeImageView.isHidden = false
                primaryTypeImageView.image = getLargeTypeImage(type: selectedPokemon.primaryType)
                backgroundColor = getTypeColors(type: selectedPokemon.primaryType)
            } else {
                primaryTypeImageView.isHidden = false
                //secondaryTypeImageView.isHidden = false
                primaryTypeImageView.image = getLargeTypeImage(type: selectedPokemon.secondaryType )
                //secondaryTypeImageView.image = getTypeImage(type: pokemon.primaryType )
                backgroundColor = getTypeColors(type: selectedPokemon.secondaryType)
            }
            
        }
    }
    
    let spriteImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleText
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let primaryTypeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = true
        tv.textAlignment = .center
        tv.font = .systemFont(ofSize: 17, weight: .regular)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup View
    
    fileprivate func setupLayout() {
        backgroundColor = .blue
        
        addSubview(cardView)
        
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.65, constant: 0))
        
        addSubview(spriteImageView)
        
        addConstraint(NSLayoutConstraint(item: spriteImageView, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: spriteImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: spriteImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 170))
        addConstraint(NSLayoutConstraint(item: spriteImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 170))
        
        addSubview(nameLabel)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 55))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: spriteImageView, attribute: .bottom, multiplier: 1, constant: 21))
        
        addSubview(primaryTypeImageView)
        
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 11))
       
        addSubview(descriptionTextView)
        
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: primaryTypeImageView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: cardView, attribute: .bottom, multiplier: 1, constant: -48))
    
    }
}
