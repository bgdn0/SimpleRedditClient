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
    
    func itemForRow(at indexPath: IndexPath) -> RDPostProtocol? {
        return dataManager.postForItem(at: indexPath)
    }
}


extension TableViewDatasourceProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath)
        guard let post = itemForRow(at: indexPath),
            let redditCell = cell as? PostTableViewCell else {
                return cell
        }
        
        redditCell.subredditLabel?.text = post.subRedditName
        redditCell.userNameLabel?.text = post.authorFullName
        redditCell.titleLabel?.text = post.title
        redditCell.votesLabel?.text = NumberUnitsFormatter.shared.format(post.votes)
        redditCell.commentsLabel?.text = "\(NumberUnitsFormatter.shared.format(post.numberOfComments)) Comment\(post.numberOfComments > 1 ? "s" : "")"
        redditCell.dateLabel?.text = post.createdDate?.timeAgoFormatted()

        
        guard let thumbnailURL = post.thumbnailURL else {
            redditCell.thumbnail = nil
            return redditCell
        }
        
        // TODO: Move to separate service!
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                redditCell.thumbnailView?.image = image
            }
        }.resume()
        
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
