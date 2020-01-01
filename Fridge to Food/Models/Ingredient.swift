//
//  Ingredient.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/12/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Foundation

struct Ingredient:Decodable {
    var id:Int
    var name:String
    var aisle: String
    var group: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case aisle = "aisle"
    }
}
