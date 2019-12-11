//
//  Recipes.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct Ingredient:Decodable {
    var name:String
}

struct Recipe:Decodable {
    var id:Int
    var title:String
    var missedIngredients:[Ingredient]
    var usedIngredients:[Ingredient]
    var unusedIngredients:[Ingredient]
    var likes:Int
}
