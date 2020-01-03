//
//  SortType.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/3/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public enum SortType : String, Codable {
    case popularity
    case healthiness
    case time
    case random
    case maxusedingredients = "max-used-ingredients"
    case minmissingingredients = "min-missing-ingredients"
}
