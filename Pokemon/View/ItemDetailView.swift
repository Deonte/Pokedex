//
//  ItemDetailView.swift
//  Pokemon
//
//  Created by Deonte on 10/22/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit
import SDWebImage

class ItemDetailView: UIView {
    
    var selectedItem: Item! {
        didSet {
            
            let sprite = selectedItem.sprite
            guard let url = URL(string: sprite) else { return }
            
            DispatchQueue.main.async {
                self.itemImageView.sd_setImage(with: url, completed: nil)
            }
            
            let name = selectedItem.name.replacingOccurrences(of: "-", with: " ")
            nameLabel.text = name
            print(name)
            let description = selectedItem.description
            descriptionTextView.text = createCleanString(description)
            priceLabel.text = "\(selectedItem.price)"
            nameLabel.text = selectedItem.name
            backgroundColor = .lightGray
        }
    }

    fileprivate func createCleanString(_ str: String) -> String {
        var newString = str.replacingOccurrences(of: " ", with: "+")
        newString = newString.description.replacingOccurrences(of: "Used+in+battle\n:+++", with: "")
        newString = newString.description.replacingOccurrences(of: "Used+on+a+party+Pokémon\n:+++", with: "")
        newString = newString.description.replacingOccurrences(of: "Used+on+a+party+Pokémon+in+battle\n:+++", with: "")
         newString = newString.description.replacingOccurrences(of: "Used+outside+of+battle\n:+++", with: "")
        newString = newString.description.replacingOccurrences(of: "Used\n:+++", with: "")
        newString = newString.replacingOccurrences(of: "\n++++", with: " ")
        newString = newString.description.replacingOccurrences(of: "+", with: " ")
        return newString
    }
    
    fileprivate let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let priceLabel: UILabel = {
       let label = UILabel()
       label.textColor = .subtitleText
       label.font = .systemFont(ofSize: 24, weight: .regular)
       label.textAlignment = .right
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    fileprivate let currencyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "currency_symbol")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleText
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    //MARK: - Setup Constraints
    
    fileprivate func setupLayout() {
        backgroundColor = .blue
        
        addSubview(cardView)
        
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.75, constant: 0))
      
        addSubview(itemImageView)
        
        addConstraint(NSLayoutConstraint(item: itemImageView, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 130))
        
        addConstraint(NSLayoutConstraint(item: itemImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 130))
        
        
        addSubview(nameLabel)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 55))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: itemImageView, attribute: .bottom, multiplier: 1, constant: 18))
        
        addSubview(priceLabel)
        
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .centerX, relatedBy: .equal, toItem: nameLabel, attribute: .centerX, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 18))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 70))
        addConstraint(NSLayoutConstraint(item: priceLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        addSubview(currencyImage)
        
        addConstraint(NSLayoutConstraint(item: currencyImage, attribute: .centerY, relatedBy: .equal, toItem: priceLabel, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: currencyImage, attribute: .leading, relatedBy: .equal, toItem: priceLabel, attribute: .trailing, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: currencyImage, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: currencyImage, attribute: .height, relatedBy: .equal, toItem: priceLabel, attribute: .height, multiplier: 0.5, constant: 0))
        

        addSubview(descriptionTextView)
        
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: priceLabel, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .bottom, relatedBy: .equal, toItem: cardView, attribute: .bottom, multiplier: 1, constant: -48))
 

    }
}
