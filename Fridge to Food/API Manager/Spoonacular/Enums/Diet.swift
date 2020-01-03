//
//  Diet.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/2/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public enum Diet : String, Codable {
    case Glutenfree = "Gluten Free"
    case Ketogenic
    case Vegetarian
    case Lactovegetarian = "Lacto-vegetarian"
    case Ovovegetarian = "Ovo-vegetarian"
    case Vegan
    case Pescetarian
    case Paleo
    case Primal
    case Whole30
    case None = "None"
}
