//
//  RedditRepository.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme

class RedditRepository {
    
    typealias EntityType = RedditItem
    let backend: URLSessionBackend
    let name = "top.json"
    
    init(backend: URLSessionBackend = .redditBackend()) {
        self.backend = backend
    }
    
    func retrieveTop(withLimit limit: Int = 25, _ after: String = "") -> Future<DictionaryInitializable, JaymeError> {
        let path = "\(self.name)?limit=\(limit)&after=\(after)"
        
        return self.backend.future(path: path, method: .GET, parameters: nil)
            .andThen { DataParser().dictionary(from: $0.0) }
            .andThen { EntityFactory<EntityType>().entity(from: $0) }
    }
}
