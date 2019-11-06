//
//  TopViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, Storyboarded {
    
    var posts: [RDPostProtocol] = []
    @IBOutlet weak var tableView: UITableView?
    
    var tableViewDatasource: TableViewDatasourceProvider?
    weak var delegate: TopListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reddit: Top"
        
        tableView?.registerRedditCell()
        tableView?.delegate = self
        tableView?.dataSource = tableViewDatasource
        tableView?.prefetchDataSource = tableViewDatasource
        
        tableViewDatasource?.relodData { [weak self] in
            self?.tableView?.reloadData()
        }
        
//        let client = RedditHTTPClient()
//        let netwProvider = NetworkDataProvider(client: client, configuration: ProviderConfiguration(endpoint: .top, limit: 50))
//        netwProvider.perforFetch { [weak self] posts in
//            print(posts.count)
//            self?.posts = posts
//
//            DispatchQueue.main.async {
//                self?.tableView?.reloadData()
//            }
//
//        }
//
        
//        client.performRequest(to: .top, params: [QueryParams.limit: String(3)]) { (result: Result<RDResponse, RDError>) in
//
//            switch result {
//            case .success(let data):
//                let a = data.listing.children
//            case .failure(let error):
//                print(error)
//            }
//
//        }
    }
    

    
    @IBAction func fullImageAction(_ sender: Any) {
//        delegate?.topListDidSelectImageWith(url: "")
    }
    
    @IBAction func postDetailsAction(_ sender: Any) {
//        delegate?.topListDidRequestNavigateToDetails(url: "")
    }
}


//extension TopViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "yourIdentifier", for: indexPath)
//        cell.textLabel?.text = posts[indexPath.row].title
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//}


extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = tableViewDatasource?.itemForRow(at: indexPath) {
            delegate?.topListDidRequestNavigateToDetails(url: post.url)
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}
