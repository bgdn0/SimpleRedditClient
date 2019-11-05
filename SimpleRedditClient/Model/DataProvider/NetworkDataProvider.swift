//
//  NetworkDataProvider.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class NetworkDataProvider: DataProvider {

    private let configuration: ProviderConfiguration
    private let httpClient: HTTPClient
    
    init(client: HTTPClient, configuration: ProviderConfiguration) {
        self.httpClient = client
        self.configuration = configuration
    }
    
    
    func perforFetch(callback: @escaping ([RDPostProtocol]) -> Void) {
        perforFetch(params: FetchParams(), callback: callback)
    }
    
    func perforFetch(params: FetchParams, callback: @escaping ([RDPostProtocol]) -> Void) {
        let queryParams = prepareQueryParams(fetchParams: params)
        
        httpClient.performRequest(to: configuration.endpoint,
                                  params: queryParams) { (result: Result<RDResponse, RDError>) in
                                    
                                    switch result {
                                    case .failure(let error):
                                        // TODO: Handle Error
                                        print("Network fetch failed: \(error.localizedDescription)")
                                        callback([])
                                    case .success(let data):
                                        let posts = data.listing.children.map { $0.data }
                                        callback(posts)
                                    }
        }
    }

    private func prepareQueryParams(fetchParams: FetchParams) -> [QueryParams: String] {
        var result = [QueryParams: String]()
        
        result[QueryParams.limit] = String(configuration.limit)
        
        if let before = fetchParams.before {
            result[QueryParams.before] = before
            
        } else if let after = fetchParams.after {
            result[QueryParams.after] = after
        }
        
        if let t = fetchParams.t {
            result[QueryParams.t] = t.rawValue
        }
        if let g = fetchParams.g {
            result[QueryParams.g] = g.rawValue
        }
        
        
        return result
    }
}
