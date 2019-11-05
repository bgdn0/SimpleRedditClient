//
//  Router.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class Router: Routable {
    public unowned let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
      self.navigationController = navigationController
    }
    
    
    func present(_ module: Presentable, animated: Bool) {
        navigationController.present(module.toPresent(), animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable, animated: Bool) {
        let controller = module.toPresent()
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func toPresent() -> UIViewController {
        return navigationController
    }
    
//    private var completions: [UIViewController : () -> Void]
    
    
}
