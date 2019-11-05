//
//  QueryParams.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

enum QueryParams: String {
    case after
    case before
    case count
    case limit
    case t
    case g
    
    enum Top: String {
        case hour
        case day
        case week
        case month
        case year
        case all
    }
    
    enum Hot: String {
        case GLOBAL
        case US
        case CA
        case GB
        case AU
    }
}
