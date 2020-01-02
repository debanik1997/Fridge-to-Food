//
//  SpoonacularIngredientClient.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 1/1/20.
//  Copyright © 2020 Debanik Purkayastha. All rights reserved.
//

import Foundation

public class SpoonacularIngredientClient : APIClient {
    private let baseEndpointUrl = URL(string: "https://api.spoonacular.com/food/ingredients/")!
    private let session = URLSession(configuration: .default)
    private let apiKey: String
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
        let endpoint = self.endpoint(for: request)
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let ingredientResponse = try JSONDecoder().decode(T.Response.self, from: data)
                    let dataContainer = DataContainer<T.Response>(results: ingredientResponse)
                    completion(.success(dataContainer))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let baseUrl = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Bad resourceName: \(request.resourceName)")
        }
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!

        let commonQueryItems = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        let customQueryItems: [URLQueryItem]
        
        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        
        components.queryItems = commonQueryItems + customQueryItems

        return components.url!
    }
}
