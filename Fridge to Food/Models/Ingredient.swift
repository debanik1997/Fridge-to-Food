//
//  Ingredient.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/12/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import UIKit
import Foundation

struct Ingredient:Codable {
    var name:String
    var group: String
    init(name: String, group: String) {
        self.name = name
        self.group = group
    }
}
