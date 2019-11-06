//
//  DataManager.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class DataManager: DataManagerProtocol {
    private var pageSize: Int
    private var maxNumberOfPages: Int
    
    private var storage: [RDPostProtocol] = []
    
    private var dataProvider: DataProvider
    var fetchParams = FetchParams()
    
    private var isFetchInProgress = false
    private var fetchCompletions = [CompletionHandler]()
    
    init(dataProvider: DataProvider, pageSize: Int, maxPages: Int) {
        self.dataProvider = dataProvider
        self.pageSize = pageSize
        self.maxNumberOfPages = maxPages
    }
    
    
    func numberOfPosts() -> Int {
        return storage.count > 0 ? min(storage.count + 1, pageSize * maxNumberOfPages) : 0
    }
    
    func postForItem(at indexPath: IndexPath) -> RDPostProtocol? {
        guard indexPath.row >= 0 && indexPath.row < storage.count else { return nil }
        return storage[indexPath.row]
    }
    
    func getOrLoadPost(at indexPath: IndexPath, completion: ((RDPostProtocol?) -> Void)) {
        if indexPath.row >= 0 && indexPath.row < storage.count {
            completion(storage[indexPath.row])
            return
        }
    }
    
    func requestLoadForItem(at indexPath: IndexPath, completion: CompletionHandler?) {
        guard indexPath.row >= storage.count && indexPath.row <= pageSize * maxNumberOfPages else {
            completion?()
            return
        }
        
        if let handler = completion {
            fetchCompletions.append(handler)
        }
        
        if !isFetchInProgress {
            isFetchInProgress = true
            dataProvider.perforFetch(params: fetchParams, callback: fetchCompletion(result:))
        }
    }
    
    func reloadData(completion: @escaping CompletionHandler) {
        storage.removeAll()
        
        fetchParams.after = nil
        requestLoadForItem(at: IndexPath(row: 0, section: 0), completion: completion)
    }
    
    private func fetchCompletion(result: [RDPostProtocol]) {
        storage.append(contentsOf: result)
        
        isFetchInProgress = false
        
        if let last =  result.last {
            fetchParams.after = last.name
        }
        
        if Thread.isMainThread {
            executeCompletions()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.executeCompletions()
            }
        }
    }
    
    private func executeCompletions() {
        for completion in fetchCompletions {
            completion()
        }
        fetchCompletions.removeAll()
    }
}
