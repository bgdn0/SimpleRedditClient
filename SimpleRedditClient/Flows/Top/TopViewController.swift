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
    @IBOutlet weak var periodSegments: UISegmentedControl?
    
    private let refreshControl = UIRefreshControl()
    
    var tableViewDatasource: TableViewDatasourceProvider?
    weak var delegate: TopListDelegate?
    
    var paramsManager: ParametersManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reddit: Top"
        periodSegments?.selectedSegmentIndex = 1 //TODO: Read from settings
        
        tableViewDatasource?.cellDelegate = self
        
        tableView?.registerRedditCell()
        tableView?.delegate = self
        tableView?.dataSource = tableViewDatasource
        tableView?.prefetchDataSource = tableViewDatasource
        tableView?.refreshControl = refreshControl
        
        paramsManager = tableViewDatasource?.makeParametersManger()
        
        tableViewDatasource?.relodData { [weak self] in
            self?.tableView?.reloadData()
        }
        
        refreshControl.addTarget(self, action: #selector(refreshRedditPosts(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    @IBAction func topPeriodChanged(_ sender: UISegmentedControl) {
        var period = QueryParams.Top.day
        switch sender.selectedSegmentIndex {
        case 0:
            period = QueryParams.Top.hour
        case 1:
            period = QueryParams.Top.day
        case 2:
            period = QueryParams.Top.week
        case 3:
            period = QueryParams.Top.month
        case 4:
            period = QueryParams.Top.year
        case 5:
            period = QueryParams.Top.all
        default:
            break
        }
        
        var fetchParams = FetchParams()
        fetchParams.t = period
        paramsManager?.updateParameters(fetchParams)
        
        sender.isUserInteractionEnabled = false
        
        tableViewDatasource?.relodData { [weak self] in
            self?.tableView?.reloadData()
            sender.isUserInteractionEnabled = true
        }
    }
    
    @objc func refreshRedditPosts(_ sender: Any) {
        tableViewDatasource?.relodData { [weak self] in
            self?.tableView?.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
}


extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let post = tableViewDatasource?.itemForRow(at: indexPath) {
            delegate?.topListDidRequestNavigateToDetails(url: post.url)
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}


extension TopViewController: PostTableViewCellDelegate {
    func didTapOnImage(for cell: PostTableViewCell) {
        guard let idxPath = tableView?.indexPath(for: cell) else { return }
        let item = tableViewDatasource?.itemForRow(at: idxPath)

        if let url = item?.fullImageURL {
            delegate?.topListDidSelectImageWith(url: url)
        }
    }
}
