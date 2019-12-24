//
//  IngredientPopupViewController.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/23/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import PopupDialog

final class IngredientPopupViewController: UIViewController {
    
    public weak var popup: PopupDialog?
    
    fileprivate var baseView: IngredientPopupView {
        return view as! IngredientPopupView
    }

    override func loadView() {
        view = IngredientPopupView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.titleLabel.text = "Add an Ingredient"
        let foodGroups = ["", "Grains", "Meat/Fish", "Dairy", "Produce", "Fats/Sugar", "Misc."]
        baseView.foodGroupPicker.loadDropdownData(data: foodGroups)
    }
    
    func getFoodGroup() -> String? {
        return baseView.foodGroupPicker.text
    }
    
    func getIngredient() -> String? {
        return baseView.ingredientText.text
    }
}
