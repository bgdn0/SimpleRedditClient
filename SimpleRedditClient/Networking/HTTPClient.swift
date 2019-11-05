//
//  HTTPClient.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func performRequest<T: Decodable>(to endpoint: Endpoints,
                                      params: [QueryParams: String],
                                      completion: @escaping (Result<T, RDError>) -> Void)
}
