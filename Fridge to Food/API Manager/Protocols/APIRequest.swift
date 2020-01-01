//
//  APIRequest.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/27/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation


public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var resourceName: String { get }
}
