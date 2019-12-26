//
//  FoodGroupCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import BadgeSwift

class FoodGroupCell : BaseCell {
    
    var ingredients: [Ingredient]? {
        didSet {
            if (ingredients!.count > 0) {
                ingredientCountBadge.fadeTransition(0.4)
                ingredientCountBadge.text = String(ingredients!.count)
            }
        }
    }
    
    var foodGroup: String? {
        didSet {
            foodGroupImage.image = UIImage(named: foodGroup!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodGroupImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let ingredientCountBadge : BadgeSwift = {
        let badge = BadgeSwift()
        
        badge.text = ""

        // Insets
        badge.insets = CGSize(width: 5, height: 5)

        // Font
        badge.font = UIFont.init(name: "verdana", size: 12)

        // Text color
        badge.textColor = UIColor(hexString: "664147")

        // Badge color
        badge.badgeColor = UIColor(hexString: "E5F9E0")

        // Shadow
        badge.shadowOpacityBadge = 0.5
        badge.shadowOffsetBadge = CGSize(width: 0, height: 0)
        badge.shadowRadiusBadge = 1.0
        badge.shadowColorBadge = UIColor.black

        // Border width and color
        badge.borderWidth = 2.0
        badge.borderColor = UIColor(hexString: "40C9A2")
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    override func setupViews() {
        addSubview(foodGroupImage)
        addSubview(ingredientCountBadge)
        
        // Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: foodGroupImage)
        // Vertical Constraint
        
        addConstraintsWithFormat(format: "V:|-10-[v0]-0-|", views: foodGroupImage)
        let constraints = [
            ingredientCountBadge.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            ingredientCountBadge.heightAnchor.constraint(equalToConstant: 30),
            ingredientCountBadge.widthAnchor.constraint(equalToConstant: 30),
            ingredientCountBadge.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 7)
        ]

        NSLayoutConstraint.activate(constraints)
        
    }
}
