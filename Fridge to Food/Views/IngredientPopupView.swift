//
//  IngredientPopupView.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit

class IngredientPopupView: UIView {

    // The title label
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    lazy var ingredientText: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        textField.textAlignment = .center
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1.0
        textField.autocapitalizationType = .words
        return textField
    }()
      
    lazy var foodGroupPicker: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        textField.textAlignment = .center
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Add views
        addSubview(titleLabel)
        addSubview(foodGroupPicker)
        addSubview(ingredientText)
        
        // Setup constraints
        heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        var constraints = [NSLayoutConstraint]()
        let views: [String: UIView] = [
            "titleLabel": titleLabel, "foodGroupPicker": foodGroupPicker, "ingredientText": ingredientText
        ]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[foodGroupPicker]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[ingredientText]|", options: [], metrics: nil, views: views)
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel(100)][ingredientText(50)][foodGroupPicker]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
    }
}
