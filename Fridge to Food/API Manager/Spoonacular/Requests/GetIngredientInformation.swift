//
//  GetIngredientInformation.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/1/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

struct GetIngredientInformation: APIRequest {
    typealias Response = Ingredient
    
    var resourceName: String {
        return "\(self.id)/information"
    }
    
    let id: Int
    let amount: Double?
    let unit: String?
    
    init(id: Int, amount: Double? = nil, unit: String? = nil) {
        self.id = id
        self.amount = amount
        self.unit = unit
    }
    
    private enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case unit = "unit"
    }
}
