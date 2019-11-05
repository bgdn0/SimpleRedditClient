//
//  RedditHTTPClient.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class RedditHTTPClient: HTTPClient {
    private let session: URLSession
    
    private let baseURL = "https://reddit.com/"
    
    init() {
        session = URLSession.shared
    }
    
    private func urlComponents(for endpoint: Endpoints) -> URLComponents? {
        let urlString = "\(baseURL)\(endpoint.rawValue).json"
        return URLComponents(string: urlString)
    }
    

    func performRequest<T>(to endpoint: Endpoints,
                           params: [QueryParams : String],
                           completion: @escaping (Result<T, RDError>) -> Void) where T : Decodable {
        
        guard var urlComponents = urlComponents(for: endpoint) else {
            completion(.failure(.badURL) )
            return
        }
        
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key.rawValue, value: $0.value) }
        guard let url = urlComponents.url else {
            completion(.failure(.badURL) )
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let error = error as NSError? {
                
                if error.code == URLError.notConnectedToInternet.rawValue ||
                    error.code == URLError.networkConnectionLost.rawValue {
                    completion(.failure(.noNetworkConnection))
                    
                } else {
                    completion(.failure(.generalError(description: error.localizedDescription)))
                }
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.http(code: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.generalError(description: "No data received from server")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(T.self, from: data)
                
                completion(.success(obj))
                
            } catch {
                completion(.failure(.parse(description: "Cannot parse object: \(T.self)")))
            }
            
        }.resume()
    }
}
