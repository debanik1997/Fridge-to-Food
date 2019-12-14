//
//  RecipeRequest.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/10/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

enum RecipeError:Error {
    case noDataAvailable
    case cannotProcessData
}

struct RecipeRequest {
    let resourceURL:URL
    let API_KEY = "488ea7c92d34469191c8296b57480d69"
    
    init(ingredients:String) {
        let resourceString = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=\(API_KEY)&ingredients=\(ingredients)"
        let urlString = resourceString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let resourceURL = URL(string: urlString ?? resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
     }
}
