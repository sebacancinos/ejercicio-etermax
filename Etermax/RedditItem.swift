//
//  Reddit.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme

enum rKind : String {
    case comment = "t1";
    case account = "t2";
    case link = "t3";
    case message = "t4";
    case subreddit = "t5";
    case award = "t6";
    case promoCampaign = "t8";
    case listing = "Listing";
}

class RedditItem: FactoryInitializable {

    static func factoryMethod(dictionary: [AnyHashable : Any]) throws -> DictionaryInitializable {
        
        guard let k  = dictionary["kind"] as? String,
            let kind = rKind(rawValue:k)
            else { throw JaymeError.parsingError }
        
        // I'm only implementing the kinds I need
        switch kind {
            case rKind.listing:
                return try RedditListing(dictionary:dictionary)
            
            case rKind.link:
                return try RedditLink(dictionary:dictionary)
            
            default:
                throw JaymeError.parsingError
        }
    }
}
