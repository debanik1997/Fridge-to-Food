//
//  SearchRecipesComplex.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct SearchRecipesComplex : APIRequest {
    typealias Response = [Recipe]

    var resourceName: String {
        return "recipes/complexSearch"
    }
    
    let query: String?
    let cuisine: String?
    let excludeCuisine: String?
    let diet: Diet?
    let intolerances: String?
    
}
