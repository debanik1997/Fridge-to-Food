//
//  ComplexRecipeWrapper.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/3/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public struct ComplexRecipeResponse: Decodable {
    var offset:Int?
    var number:Int?
    var results:[Recipe]?
    var totalResults: Int?
}
