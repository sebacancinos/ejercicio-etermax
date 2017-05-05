//
//  FakeBackend.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//
import Foundation
import Jayme

@testable import Etermax

class FakeBackend: URLSessionBackend {
    
    var path: Path?
    var method: HTTPMethodName?
    var parameters: [AnyHashable: Any]?
    
    var completion: Future<(Data?, PageInfo?), JaymeError>.FutureAsyncOperation = { completion in }
    
    override func future(path: String, method: HTTPMethodName, parameters: [AnyHashable: Any]? = nil) -> Future <(Data?, PageInfo?), JaymeError> {
        self.path = path
        self.method = method
        self.parameters = parameters
        return Future(operation: self.completion)
    }
    
}
