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
    
    public fileprivate(set) var selectedIngredient: String?
    
    public var foodGroups = [String]() {
        didSet { baseView.foodGroupPicker.loadDropdownData(data: foodGroups)}
    }

    override func loadView() {
        view = IngredientPopupView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.titleLabel.text = "Add an Ingredient"
        baseView.ingredientDropdown.optionArray = getAllIngredients()
        baseView.ingredientDropdown.didSelect{(selectedText , index ,id) in
            self.selectedIngredient = selectedText
        }
    }
    
    func getFoodGroup() -> String? {
        return baseView.foodGroupPicker.text
    }
    
    func getAllIngredients() -> [String] {
        if let path = Bundle.main.path(forResource: "ingredients", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let dictionary = jsonResult as? Dictionary<String, AnyObject> {
                    return Array(dictionary.keys).sorted().map({$0.capitalized })
                  } else {
                    return []
                }
              } catch {
                return []
              }
        } else {
            return []
        }
    }
    
    func getIngredient() -> String? {
//        return baseView.ingredientDropdown.selectedIndex
//        if let selectedIndex = baseView.ingredientDropdown.selectedIndex {
//            return baseView.ingredientDropdown.optionArray[selectedIndex]
//        }
        return baseView.ingredientText.text
    }
}
