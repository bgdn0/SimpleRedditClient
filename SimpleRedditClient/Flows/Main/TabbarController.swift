//
//  TabbarViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, Storyboarded {
    override func viewDidLoad() {
      super.viewDidLoad()
      delegate = self
    }
}

extension TabbarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
//          return false
//        }
//
//        if fromView != toView {
//          UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
//        }
//
//        return true
//    }
}
