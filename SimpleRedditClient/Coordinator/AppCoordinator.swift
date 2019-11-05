//
//  File.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let rootViewController: UIViewController
    
    private var childCoordinators = [Coordinator]()
    
    
    init() {
        self.rootViewController = TabbarController.instantiate(from: Storyboards.main)
    }
    
    func start() {
        if let navigationController = rootViewController.children.first as? UINavigationController {
            let topCoordinator = TopCoordinator(presenter: Router(navigationController: navigationController))
            topCoordinator.start()
            childCoordinators.append(topCoordinator)
        }
        
        if rootViewController.children.count > 1,
            let navigationController = rootViewController.children.last as? UINavigationController {
            let hotCoordinator = HotCoordinator(presenter: Router(navigationController: navigationController))
            hotCoordinator.start()
            childCoordinators.append(hotCoordinator)
        }
    }
}
