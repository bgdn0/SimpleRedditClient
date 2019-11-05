//
//  TableViewDatasourceFactory.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

enum TableViewControllerType {
    case top, hot
}

class TableViewDatasourceFactory {
    static func provider(for controller: TableViewControllerType) -> TableViewDatasourceProvider {
        let pageSize = 40
        let maxPages = 13
        
        let endpoint = controller == .top ? Endpoints.top : Endpoints.hot
        
        let netwProvider = NetworkDataProvider(client: RedditHTTPClient(),
                                               configuration: ProviderConfiguration(endpoint: endpoint, limit: pageSize))
        let dataManger = DataManager(dataProvider: netwProvider, pageSize: pageSize, maxPages: maxPages)
        
        return TableViewDatasourceProvider(dataManager: dataManger)
    }
}
