//
//  Diet.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public enum Diet : String, Codable {
    case glutenfree = "gluten free"
    case ketogenic
    case vegetarian
    case lactovegetarian = "lacto-vegetarian"
    case ovovegetarian = "ovo-vegetarian"
    case vegan
    case pescetarian
    case paleo
    case primal
    case whole30
}
