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
    
            nameLabel.text = selectedMove.name.capitalized
            typeImageView.image = getTypeImage(type: selectedMove.type)
            primaryTypeImageView.image = getLargeTypeImage(type: selectedMove.type)
            descriptionTextView.text = replace(if: selectedMove.effect, contains: "$effect_chance", with: selectedMove.effectChance)
            basePowerText.text = "\(selectedMove.basePower)"
            accuracyText.text = "\(selectedMove.accuracy)%"
            ppText.text = "\(selectedMove.pp)"
            backgroundColor = getTypeColors(type: selectedMove.type)
            
        }
    }
    
    fileprivate let typeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate let typeImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 70
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 20.0, blur: 40.0, spread: 0)
        return view
    }()
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 36
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleText
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let primaryTypeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate let descriptionText: UILabel = {
        let label = UILabel()
        label.numberOfLines = -1
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
    
    fileprivate let basePowerView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let basePowerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Base Power"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .blueTitle
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let basePowerText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .light)
        label.textColor = .titleText
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let accuracyView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let accuracyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Accuracy"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .blueTitle
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let accuracyText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .light)
        label.textColor = .titleText
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let ppView: UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate let ppTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "PP"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .blueTitle
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let ppText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .light)
        label.textColor = .titleText
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lineView2: UIView = {
           let view = UIView()
           view.backgroundColor = .lightGray
           view.widthAnchor.constraint(equalToConstant: 1).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
 
    fileprivate lazy var  overallStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [UIView(), basePowerView, lineView, accuracyView, lineView2, ppView, UIView()])
        sv.distribution = .equalCentering
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
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
        addConstraint(NSLayoutConstraint(item: cardView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.65, constant: 0))
        
        
        addSubview(typeImageContainer)
        
        addConstraint(NSLayoutConstraint(item: typeImageContainer, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageContainer, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageContainer, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 140))
        addConstraint(NSLayoutConstraint(item: typeImageContainer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 140))
        
        
        addSubview(typeImageView)

        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .centerY, relatedBy: .equal, toItem: typeImageContainer, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .centerX, relatedBy: .equal, toItem: typeImageContainer, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 130))
        addConstraint(NSLayoutConstraint(item: typeImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 130))
        
        
        addSubview(nameLabel)
        
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 55))
        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: typeImageContainer, attribute: .bottom, multiplier: 1, constant: 18))
        
        addSubview(primaryTypeImageView)
        
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .centerX, relatedBy: .equal, toItem: cardView, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: primaryTypeImageView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 11))
        
        addSubview(descriptionTextView)
        
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: -18))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .top, relatedBy: .equal, toItem: primaryTypeImageView, attribute: .bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 150))
        
        addSubview(overallStackView)
        
        addConstraint(NSLayoutConstraint(item: overallStackView , attribute: .leading, relatedBy: .equal, toItem: cardView, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: overallStackView , attribute: .trailing, relatedBy: .equal, toItem: cardView, attribute: .trailing, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: overallStackView , attribute: .top, relatedBy: .equal, toItem: descriptionTextView, attribute: .bottom, multiplier: 1, constant: 22))
        addConstraint(NSLayoutConstraint(item: overallStackView , attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 140))
        
        basePowerView.addSubview(basePowerTitleLabel)
        basePowerTitleLabel.anchor(top: basePowerView.topAnchor, leading: basePowerView.leadingAnchor, bottom: nil, trailing: basePowerView.trailingAnchor, padding: .init(top: 8, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 30))
        
        basePowerView.addSubview(basePowerText)
        basePowerText.anchor(top: basePowerTitleLabel.bottomAnchor, leading: basePowerView.leadingAnchor, bottom: nil, trailing: basePowerView.trailingAnchor, padding: .init(top: 22, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 50))
        
        accuracyView.addSubview(accuracyTitleLabel)
        accuracyTitleLabel.anchor(top: accuracyView.topAnchor, leading: accuracyView.leadingAnchor, bottom: nil, trailing: accuracyView.trailingAnchor, padding: .init(top: 8, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 30))
        
        accuracyView.addSubview(accuracyText)
        accuracyText.anchor(top: accuracyTitleLabel.bottomAnchor, leading: accuracyView.leadingAnchor, bottom: nil, trailing: accuracyView.trailingAnchor, padding: .init(top: 22, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 50))
        
        ppView.addSubview(ppTitleLabel)
        ppTitleLabel.anchor(top: ppView.topAnchor, leading: ppView.leadingAnchor, bottom: nil, trailing: ppView.trailingAnchor, padding: .init(top: 8, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 30))
        
        ppView.addSubview(ppText)
        ppText.anchor(top: accuracyTitleLabel.bottomAnchor, leading: ppView.leadingAnchor, bottom: nil, trailing: ppView.trailingAnchor, padding: .init(top: 22, left: 5, bottom: 0, right: 5), size: .init(width: 0, height: 50))
        
    }
}

