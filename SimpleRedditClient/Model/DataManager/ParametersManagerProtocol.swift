//
//  ParametersManagerProtocol.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 06.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol ParametersManagerProtocol {
    var dataManager: DataManagerProtocol { get }
    
    func updateParameters(_ params: FetchParams)
}
