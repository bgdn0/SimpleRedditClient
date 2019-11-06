//
//  PostDetailsViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit
import WebKit

class PostDetailsViewController: UIViewController, Storyboarded {
    
    var redditPostURL: URL?

    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = redditPostURL else { return }
        
        activityIndicator?.startAnimating()
        webView?.navigationDelegate = self
        webView?.load(URLRequest(url: url))
    }
}

extension PostDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
      didFinish navigation: WKNavigation!) {
        activityIndicator?.stopAnimating()
    }
}
