//
//  Recipes.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Foundation

class Recipe: NSObject {
    var id:Int?
    var title:String?
    var image:String?
    var ingredients:[Ingredient]?
//    var missedIngredientsCount:Int?
//    var missedIngredients:[Ingredient]
//    var usedIngredients:[Ingredient]
//    var unusedIngredients:[Ingredient]
    var likes:Int?
}
