//
//  ItemsListDelegate.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol TopListDelegate: AnyObject {
    func topListDidRequestNavigateToDetails(url: URL)
    func topListDidSelectImageWith(url: URL)
}
