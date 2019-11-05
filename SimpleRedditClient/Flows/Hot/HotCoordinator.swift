//
//  PopularCoordinator.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class HotCoordinator: Coordinator {
    
    private var presenter: Router
    
    init(presenter: Router) {
        self.presenter = presenter
    }
    
    func start() {
        let hotViewController = HotViewController.instantiate(from: Storyboards.hot)
        hotViewController.delegate = self
        presenter.push(hotViewController, animated: true)
    }
}

extension HotCoordinator: HotListDelegate {
    func hotListDidRequestNavigateToDetails(url: String) {
        
    }
    
    func hotListDidSelectImageWith(url: String) {
         
    }
    
    
}
