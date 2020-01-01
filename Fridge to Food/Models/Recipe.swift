//
//  Recipes.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Foundation

public struct Recipe: Decodable {
    var id:Int?
    var title:String?
    var image:String?
    var likes:Int?
    var missedIngredients:[Ingredient]?
    var usedIngredients:[Ingredient]?
    
    init(id: Int? = nil, title: String? = nil, image: String? = nil, likes: Int? = nil, missedIngredients: [Ingredient]? = nil, usedIngredients: [Ingredient]? = nil) {
        self.id = id
        self.title = title
        self.image = image
        self.likes = likes
        self.missedIngredients = missedIngredients
        self.usedIngredients = usedIngredients
    }
}
