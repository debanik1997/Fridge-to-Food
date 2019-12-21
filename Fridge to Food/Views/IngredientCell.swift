//
//  IngredientCell.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/21/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class IngredientCell: BaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let ingredientImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    let ingredientLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "Ingredient"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        addSubview(ingredientImageView)
        addSubview(ingredientLabel)
        
        // Horizontal Constraint
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: ingredientImageView)
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: ingredientLabel)
        
        // Vertical Constraint
        addConstraintsWithFormat(format: "V:|-0-[v0]-3-[v1(50)]-0-|", views: ingredientImageView, ingredientLabel)
        
    }
}
