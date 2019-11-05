//
//  RDError.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

public enum RDError: Error {
    case badURL
    case invalidResponse
    case noNetworkConnection
    case http(code: Int)
    case parse(description: String?)
    case generalError(description: String?)
}
