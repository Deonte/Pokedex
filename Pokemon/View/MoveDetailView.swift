//
//  MoveDetailView.swift
//  Pokemon
//
//  Created by Deonte on 10/19/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class MoveDetailView: UIView {
    
    var selectedMove: Move! {
        didSet {
    
            nameLabel.text = selectedMove.name
            typeImageView.image = getTypeImage(type: selectedMove.type)
            primaryTypeImageView.image = getLargeTypeImage(type: selectedMove.type)
            descriptionText.text = selectedMove.effect
            backgroundColor = getTypeColors(type: selectedMove.type)
        }
    }
    
    let typeImageView: UIImageView = {
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
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.80, constant: 0))
        
        addSubview(typeImageView)
        
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 170))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 170))
        
        addSubview(nameLabel)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 55))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: typeImageView, attribute: .bottom, multiplier: 1, constant: 21))
        
        addSubview(primaryTypeImageView)
        
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 11))
        
        addSubview(descriptionText)
        
        addConstraint(NSLayoutConstraint(item: descriptionText, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionText, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionText, attribute: .top, relatedBy: .equal, toItem: primaryTypeImageView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionText, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 100))

        
    }
}
