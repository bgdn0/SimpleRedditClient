//
//  TableViewDatasourceProvider.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class TableViewDatasourceProvider: NSObject {
    private var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func relodData(completion: @escaping () -> Void) {
        dataManager.reloadData {
            completion()
        }
    }
}


extension TableViewDatasourceProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath)
        guard let post = dataManager.postForItem(at: indexPath) else { return cell }
        
        cell.textLabel?.text = post.title
        
        return cell
    }
}


extension TableViewDatasourceProvider: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for idxPath in indexPaths {
            let completion: () -> Void = {
                tableView.reloadData()
            }
            dataManager.requestLoadForItem(at: idxPath, completion: (idxPath.row == dataManager.numberOfPosts()-1 ? completion : nil))
        }
    }
}
