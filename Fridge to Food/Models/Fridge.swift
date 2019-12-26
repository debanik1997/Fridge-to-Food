//
//  Fridge.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/20/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

class Fridge: CustomStringConvertible {
    var ingredients: [Ingredient]
    
    init() {
        ingredients = [Ingredient]()
    }
    
    // for testing
    public var description: String {
        var s = ""
        for ingredient in self.ingredients {
            s.append("[\(ingredient.group): \(ingredient.name))]")
            s.append(", ")
        }
        return s
    }
    
    func addIngredient(ingredient: Ingredient) {
        self.ingredients.append(ingredient)
    }
}

