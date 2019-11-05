//
//  TopViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, Storyboarded {
    
    weak var delegate: TopListDelegate?
    
    @IBAction func fullImageAction(_ sender: Any) {
        delegate?.topListDidSelectImageWith(url: "")
    }
    
    @IBAction func postDetailsAction(_ sender: Any) {
        delegate?.topListDidRequestNavigateToDetails(url: "")
    }
}
