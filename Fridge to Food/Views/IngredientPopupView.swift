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
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.optionArray = ["debanik", "purkayastha"]
        dropDown.placeholder = "Name of ingredient..."
        dropDown.listHeight = 100
        dropDown.backgroundColor = UIColor(hexString: "E5F9E0")
        return dropDown
    }()
    
    lazy var dropDownHolder : UIView = {
        let  view = UIView(frame: .zero) // set frame
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.5
        view.backgroundColor = UIColor(hexString: "E5F9E0")
        return view
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Setup constraints
        heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        addSubview(titleLabel)
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        addSubview(dropDownHolder)
        
        let ingredientDropdownHolderConstraints = [
            dropDownHolder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            dropDownHolder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dropDownHolder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            dropDownHolder.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(ingredientDropdownHolderConstraints)
        
        dropDownHolder.addSubview(ingredientDropdown)
        let ingredientDropdownConstraints = [
            ingredientDropdown.centerYAnchor.constraint(equalTo: dropDownHolder.centerYAnchor),
            ingredientDropdown.leadingAnchor.constraint(equalTo: dropDownHolder.leadingAnchor, constant: 10),
            ingredientDropdown.rightAnchor.constraint(equalTo: dropDownHolder.rightAnchor, constant: -25),
            ingredientDropdown.heightAnchor.constraint(equalToConstant: 70)
        ]
        NSLayoutConstraint.activate(ingredientDropdownConstraints)
        
    }
}
