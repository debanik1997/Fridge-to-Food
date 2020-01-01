//
//  GetRecipes.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/27/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

// TO-DO
struct SearchRecipesByIngredients: APIRequest {
    typealias Response = [Recipe]

    var resourceName: String {
        return "findByIngredients"
    }
    
    // parameters
    let ingredients: String?
    let number: Int?
    let limitLicense: Bool?
    let ranking: Int?
    let ignorePantry: Bool?

    init(ingredients: String? = nil,
         number: Int? = nil,
         limitLicense: Bool? = nil,
         ranking: Int? = nil,
         ignorePantry: Bool? = nil) {
        self.ingredients = ingredients
        self.number = number
        self.limitLicense = limitLicense
        self.ranking = ranking
        self.ignorePantry = ignorePantry
    }
}
