//
//  HotListDelegate.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol HotListDelegate: AnyObject {
    func hotListDidRequestNavigateToDetails(url: String)
    func hotListDidSelectImageWith(url: String)
}
