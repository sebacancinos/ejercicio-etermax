//
//  RedditBackend.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import Jayme

extension URLSessionBackend {
    class func redditBackend() -> URLSessionBackend {
        let basePath = "https://www.reddit.com"
        let headers = [HTTPHeader(field: "Accept", value: "application/json"),
                       HTTPHeader(field: "Content-Type", value: "application/json")]
        // and any header you need to use
        let configuration = URLSessionBackendConfiguration(basePath: basePath, httpHeaders: headers)
        return URLSessionBackend(configuration: configuration)
    }
}
