//
//  DataManagerProtocol.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    typealias CompletionHandler = () -> Void
    
    var fetchParams: FetchParams { get set }

    func numberOfPosts() -> Int
    func postForItem(at indexPath: IndexPath) -> RDPostProtocol?
    func getOrLoadPost(at indexPath: IndexPath, completion: ((RDPostProtocol?) -> Void))
    func requestLoadForItem(at indexPath: IndexPath, completion: CompletionHandler? )
    func reloadData(completion: @escaping CompletionHandler)
}
