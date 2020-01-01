//
//  IngredientPopupView.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import iOSDropDown

class IngredientPopupView: UIView {

    // The title label
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        label.textAlignment = .center
        label.backgroundColor = UIColor(hexString: "A3F7B5")
        return label
    }()
    
    lazy var ingredientText: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Name of ingredient..."
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
        textField.placeholder = "Choose a food group..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1)
        textField.textAlignment = .center
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1.0
        return textField
    }()
    
    lazy var ingredientDropdown : DropDown = {
        let  dropDown = DropDown(frame: .zero) // set frame
        // The list of array to display. Can be changed dynamically
//        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.optionArray = ["debanik", "purkayastha"]
        dropDown.placeholder = "Name of ingredient..."
        dropDown.listHeight = 100
        return dropDown
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Setup constraints
        heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        addSubview(titleLabel)
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        addSubview(ingredientDropdown)
        let ingredientDropdownConstraints = [
            ingredientDropdown.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            ingredientDropdown.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            ingredientDropdown.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(ingredientDropdownConstraints)
        
        
//        var constraints = [NSLayoutConstraint]()
//        let views: [String: UIView] = [
//            "titleLabel": titleLabel, "foodGroupPicker": foodGroupPicker, "ingredientDropdown": ingredientDropdown
//        ]
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[foodGroupPicker]|", options: [], metrics: nil, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: [], metrics: nil, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[ingredientDropdown]|", options: [], metrics: nil, views: views)
//
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel(100)][ingredientDropdown(50)][foodGroupPicker]|", options: [], metrics: nil, views: views)
//        NSLayoutConstraint.activate(constraints)
    }
}
