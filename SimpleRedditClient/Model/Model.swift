//
//  Model.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

struct RDResponse: Decodable {
    let listing: RDListing
    
    enum CodingKeys : String, CodingKey {
        case listing = "data"
    }
}

struct RDListing: Decodable {
    let after: String?
    let before: String?
    let children: [RDChild]
}

struct RDChild: Decodable {
    let kind: String
    var data: RDPost
}

struct RDPost: Decodable {
    var name: String
    var subRedditName: String
    var authorFullName: String
    var title: String
    var createdDate: Date?
    var votes: Int
    var numberOfComments: Int
    var url: URL
    var thumbnailURL: URL?
    var fullImageURL: URL?
    var preview: RDPreview?
    
    enum CodingKeys : String, CodingKey {
        case name
        case subRedditName = "subreddit_name_prefixed"
        case authorFullName = "author_fullname"
        case title
        case createdDate = "created_utc"
        case votes = "ups"
        case numberOfComments = "num_comments"
        case url
        case thumbnailURL = "thumbnail"
        case preview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.subRedditName = try container.decode(String.self, forKey: .subRedditName)
        self.authorFullName = try container.decode(String.self, forKey: .authorFullName)
        self.title = try container.decode(String.self, forKey: .title)
        self.votes = try container.decode(Int.self, forKey: .votes)
        self.numberOfComments = try container.decode(Int.self, forKey: .numberOfComments)
        self.createdDate = Date(timeIntervalSince1970: try container.decode(Double.self, forKey: .createdDate))
        self.url = try container.decode(URL.self, forKey: .url)
        self.thumbnailURL = try? container.decode(URL.self, forKey: .thumbnailURL)
        if let preview = try? container.decode(RDPreview.self, forKey: .preview) {
            self.preview = preview
            if let firstImg = preview.images.first {
                self.fullImageURL = firstImg.source.url
            }
        }
    }
}

struct RDPreview: Decodable {
    let images: [RDImage]
}

struct RDImage: Decodable {
    let source: RDImageSource
}

struct RDImageSource: Decodable {
    let url: URL
}
