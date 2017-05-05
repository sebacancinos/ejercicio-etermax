//
//  RedditListing.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme


struct RedditListing: Identifiable {
    let modhash: String
    let children: [DictionaryInitializable]
    let before: String
    let after: String
    
    let id: String
    let kind: rKind
    let data: [String: Any]
}

extension RedditListing: DictionaryInitializable, DictionaryRepresentable {
    
    init(dictionary: [AnyHashable : Any]) throws {
        
        guard let k  = dictionary["kind"] as? String,
            let kind = rKind(rawValue:k) ,
            let data = dictionary["data"] as? [String:Any],
            let after = data["after"] as? String,
            let modhash = data["modhash"] as? String,
            let children = data["children"] as? [[String: Any]]
            else { throw JaymeError.parsingError }
        

        self.kind = kind
        self.id  = ""
        self.data = data
        self.modhash = modhash
        self.after = after
        if let before = data["before"] as? String
        {
            self.before = before
        } else {
            self.before = ""
        }
        
        self.children = try children.map {(child: [String: Any]) in
            return try RedditItem.factoryMethod(dictionary: child)
        }
    }
    
    var dictionaryValue: [AnyHashable : Any] {
        return ["id": "",
                "kind": self.kind.rawValue,
                "data": self.data] as [String: Any]
    }
    
    func append(_ newList: RedditListing) -> RedditListing{
        
        let children = self.children + newList.children
        
        return RedditListing(modhash: self.modhash, children: children, before: self.before, after: newList.after, id: self.id, kind: self.kind, data: self.data)
    }
}

