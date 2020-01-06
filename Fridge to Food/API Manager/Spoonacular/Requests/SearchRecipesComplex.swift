//
//  SearchRecipesComplex.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct SearchRecipesComplex : APIRequest {
    typealias Response = ComplexRecipeResponse

    var resourceName: String {
        return "complexSearch"
    }
    
    let query: String?
    let diet: String?
    let intolerances: String?
    let includeIngredients: String?
    let type: String?
    let sort: String?
    let fillIngredients: Bool?
    let number: Int?
    
    init(query: String? = nil,
         diet: String? = nil,
         intolerances: String? = nil,
         includeIngredients: String? = nil,
         type: String? = nil,
         sort: String? = nil,
         fillIngredients: Bool? = nil,
         number: Int? = nil) {
        self.query = query
        self.diet = diet
        self.intolerances = intolerances
        self.includeIngredients = includeIngredients
        self.type = type
        self.sort = sort
        self.fillIngredients = fillIngredients
        self.number = number
    }
}
