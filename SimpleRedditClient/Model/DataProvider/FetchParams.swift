//
//  FetchParams.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

struct FetchParams {
    var after: String?
    var before: String?
    var count: Int = 0
    var t: QueryParams.Top?
    var g: QueryParams.Hot?
}
