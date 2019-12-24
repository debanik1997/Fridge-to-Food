//
//  FoodGroupCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class FoodGroupCell : BaseCell {
    
    var foodGroup: String? {
        didSet {
            // Set views based on recipe
            foodGroupLabel.text = foodGroup
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let foodGroupLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    override func setupViews() {
        addSubview(foodGroupLabel)
        
        // Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: foodGroupLabel)
        
        // Vertical Constraint
        addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: foodGroupLabel)
        
    }
}
