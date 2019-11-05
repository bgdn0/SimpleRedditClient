//
//  Routable.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

protocol Routable: Presentable {
    var navigationController: UINavigationController { get }
    
    func present(_ module: Presentable, animated: Bool)
    func push(_ module: Presentable, animated: Bool)
    func pop(animated: Bool)
}
