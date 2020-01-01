//
//  APIClient.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/27/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

protocol APIClient {
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<DataContainer<T.Response>, Error>) -> Void
    )
}
