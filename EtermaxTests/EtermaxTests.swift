//
//  EtermaxTests.swift
//  EtermaxTests
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import XCTest
@testable import Etermax
import Jayme

class RedditRepositoryTests: XCTestCase {
    
    var repository: RedditRepository!
    var backend: FakeBackend!
    
    override func setUp() {
        super.setUp()
        backend = FakeBackend()
        repository = RedditRepository(backend: backend)
    }
    
    func testRetrieveTopCallToBackend() {
        self.backend.completion = { completion in
            completion(.success((nil, nil)))
        }
        
        let expectation = self.expectation(description: "")
        let future = repository.retrieveTop(withLimit: 20, "t3_1234")
        future.start() { result in
            XCTAssertEqual(self.backend.path!, "top.json?limit=20&after=t3_1234")
            XCTAssertEqual(self.backend.method, .GET)
            XCTAssertNil(self.backend.parameters)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3) { error in
            if let _ = error { XCTFail() }
        }
    }
    
    func testRetrieveTopEmptyCallToBackend() {
        self.backend.completion = { completion in
            completion(.success((nil, nil)))
        }
        
        let expectation = self.expectation(description: "")
        let future = repository.retrieveTop()
        future.start() { result in
            XCTAssertEqual(self.backend.path!, "top.json?limit=25&after=")
            XCTAssertEqual(self.backend.method, .GET)
            XCTAssertNil(self.backend.parameters)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3) { error in
            if let _ = error { XCTFail() }
        }
    }
    
    func testRetrieveTopRequestFailure() {
        self.backend.completion = { completion in
            completion(.failure(JaymeError.notFound))
        }
        let expectation = self.expectation(description: "")
        
        let future = repository.retrieveTop()
        future.start() { result in
            guard case .failure(_) = result
                else { XCTFail(); return }
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 3) { error in
            if let _ = error { XCTFail() }
        }
    }
    
    func testFindByIdRequestSuccess() {
        let dict = ["kind": "Listing",
                    "data": [
                        "modhash": "",
                        "children": [
                        ["kind": "t3",
                            "data": [
                                "subreddit": "pics",
                                "id": "696bqk",
                                "author": "testing",
                                "thumbnail": "https://test/thumb.jpg",
                                "created": 1493915990,
                                "title": "Testing parsing.",
                                "num_comments": 2410,
                            ]
                        ],
                        ["kind": "t3",
                         "data": [
                            "subreddit": "pics",
                            "id": "696bqk",
                            "author": "testing",
                            "thumbnail": "https://test/thumb.jpg",
                            "created": 1493915990,
                            "title": "Testing parsing.",
                            "num_comments": 2410,
                            ]
                        ]
                    ],
                    "after": "t3_697kn4"
                    ]] as [String: Any]
        
        let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        self.backend.completion = { completion in
            completion(.success((data, nil)))
        }
        let expectation = self.expectation(description: "")
        let future = repository.retrieveTop()
        future.start() { result in
            guard case .success(let entity as RedditListing) = result
                else { XCTFail(); return }
            XCTAssertEqual(entity.kind, rKind.listing)
            XCTAssertEqual(entity.children.count, 2)
            XCTAssertEqual(entity.after, "t3_697kn4")
            
            if let firstItem = entity.children.first as? RedditLink {
                XCTAssertEqual(firstItem.kind, rKind.link)
                XCTAssertEqual(firstItem.id, "696bqk")
                XCTAssertEqual(firstItem.subReddit, "pics")
                XCTAssertEqual(firstItem.author, "testing")
                XCTAssertEqual(firstItem.thumbnail, "https://test/thumb.jpg")
                XCTAssertEqual(firstItem.title, "Testing parsing.")
                XCTAssertEqual(firstItem.commentCnt, 2410)
                XCTAssertEqual(firstItem.date.description, "2017-05-04 16:39:50 +0000" )
            } else { XCTFail(); return }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3) { error in
            if let _ = error { XCTFail() }
        }
    }
}
