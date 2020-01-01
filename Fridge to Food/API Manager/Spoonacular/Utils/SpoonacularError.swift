//
//  SpoonacularError.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/1/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public enum SpoonacularError: Error {
    case encoding
    case decoding
    case server(message: String)
}
