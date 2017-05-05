//
//  RedditLink.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme


struct RedditLink: Identifiable {
    let id: String
    let kind: rKind
    let data: [String: Any]
    let title: String
    let author: String
    let date: Date
    let thumbnail: String?
    let commentCnt: Int
    let subReddit: String
}

extension RedditLink: DictionaryInitializable, DictionaryRepresentable {
    
    init(dictionary: [AnyHashable : Any]) throws {
        
        guard let k  = dictionary["kind"] as? String,
            let kind = rKind(rawValue:k) ,
            let data = dictionary["data"] as? [String:Any],
            let id = data["id"] as? String,
            let title = data["title"] as? String,
            let author = data["author"] as? String,
            let created = data["created"] as? Int,
            let numComment = data["num_comments"] as? Int,
            let subReddit = data["subreddit"] as? String,
            let thumbnail = data["thumbnail"] as? String
        
        else { throw JaymeError.parsingError }
        
        self.kind = kind
        self.id  = id
        self.data = data
        
        self.title = title
        self.author = author
        self.thumbnail = thumbnail
        self.commentCnt = numComment
        self.subReddit = subReddit
        self.date = Date.init(timeIntervalSince1970: TimeInterval(created))
    }
    
    var dictionaryValue: [AnyHashable : Any] {
        return ["id": "",
                "kind": self.kind.rawValue,
                "data": self.data] as [String: Any]
    }
}

