//
//  ParametersManager.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 06.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class ParametersManager: ParametersManagerProtocol {
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func updateParameters(_ params: FetchParams) {
        if let before = params.before {
            dataManager.fetchParams.before = before
        }
        if let after = params.after {
            dataManager.fetchParams.after = after
        }
        if let t = params.t {
            dataManager.fetchParams.t = t
        }
        if let g = params.g {
            dataManager.fetchParams.g = g
        }
    }
}
