//
//  DataProvider.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol DataProvider {
    func perforFetch(callback: @escaping ([RDPostProtocol]) -> Void)
    func perforFetch(params: FetchParams, callback: @escaping ([RDPostProtocol]) -> Void)
}
