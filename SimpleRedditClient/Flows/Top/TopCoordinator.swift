//
//  TopCoordinator.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class TopCoordinator: Coordinator {
    
    private var presenter: Router
    
    init(presenter: Router) {
        self.presenter = presenter
    }
    
    func start() {
        let topViewController = TopViewController.instantiate(from: Storyboards.top)
        topViewController.delegate = self
        presenter.push(topViewController, animated: true)
    }
}

extension TopCoordinator: TopListDelegate {
    func topListDidRequestNavigateToDetails(url: String) {
        let detailsController = PostDetailsViewController.instantiate(from: Storyboards.details)
        presenter.push(detailsController, animated: true)
    }
    
    func topListDidSelectImageWith(url: String) {
        let imageController = FullImageViewController.instantiate(from: Storyboards.details)
        
        let nav = UINavigationController()
        nav.setViewControllers([imageController], animated: true)
        nav.isNavigationBarHidden = false
        presenter.present(nav, animated: true)
    }
}