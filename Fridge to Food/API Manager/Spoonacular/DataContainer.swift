//
//  DataContainer.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/1/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public struct DataContainer<Results: Decodable>: Decodable {
    public let results: Results
    
    public init(results: Results) {
        self.results = results
    }
}
