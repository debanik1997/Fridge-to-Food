//
//  SpoonacularRecipeClient.swift
//  Fridge to Food
//
//  Created by Debanik Purkayastha on 12/31/19.
//  Copyright © 2019 Debanik Purkayastha. All rights reserved.
//

import Foundation

typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

public class SpoonacularRecipeClient : APIClient {
    private let baseEndpointUrl = URL(string: "https://api.spoonacular.com/recipes/")!
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
                    let recipeResponse = try JSONDecoder().decode(T.Response.self, from: data)
                    let dataContainer = DataContainer<T.Response>(results: recipeResponse)
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
