//
//  UIViewController+Instantiating.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(from storyboard: Storyboards) -> Self {
        let contollerId = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: contollerId) as! Self
    }
}
