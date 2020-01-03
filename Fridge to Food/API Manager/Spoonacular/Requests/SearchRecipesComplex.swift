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
    let diet: Diet?
    let intolerances: String?
    let includeIngredients: String?
    let type: MealType?
    let sort: SortType?
    
    init(query: String? = nil,
         diet: Diet? = nil,
         intolerances: String? = nil,
         includeIngredients: String? = nil,
         type: MealType? = nil,
         sort: SortType? = nil) {
        self.query = query
        self.diet = diet
        self.intolerances = intolerances
        self.includeIngredients = includeIngredients
        self.type = type
        self.sort = sort
    }
}
