//
//  RedditCellPresenterTests.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/5/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import XCTest
@testable import Etermax

class RedditCellPresenterTestsTests: XCTestCase {
    var listing:RedditListing!
    var presenter: RedditCellPresenter!
    
    override func setUp() {
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
            ]] as [AnyHashable: Any]
        
        do { self.listing = try RedditItem.factoryMethod(dictionary: dict) as! RedditListing
        } catch { XCTFail() }

        self.presenter = RedditCellPresenter(forLink: listing.children.first as! RedditLink)
    }
    
    func testAttributedTitleTextSuccess() {
        
        let title = self.presenter.attributedTitle
        
        XCTAssertEqual(title?.string, "Testing parsing.")
    }
    
    func testAttributedTitleFormatSuccess() {
        
        guard let title = self.presenter.attributedTitle,
            let font = title.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont,
            let color = title.attribute(NSForegroundColorAttributeName, at:0, effectiveRange: nil) as? UIColor else
            {
                XCTFail()
                return
            }
        
        XCTAssertEqual(font.fontName, ".SFUIDisplay-Semibold")
        XCTAssertEqual(font.pointSize,  UIFont.labelFontSize * 1.2)
        XCTAssertEqual(color, UIColor(rgba:"#2d528eFF"))
    }

    func testAttributedCommentsTextSuccess() {
        
        let comments = self.presenter.attributedComments
        
        XCTAssertEqual(comments?.string, "2410 comments")
    }
    
    func testAttributedCommentsFormatSuccess() {
        
        guard let comments = self.presenter.attributedComments,
            let font = comments.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont,
            let color = comments.attribute(NSForegroundColorAttributeName, at:0, effectiveRange: nil) as? UIColor else
        {
            XCTFail()
            return
        }
        
        XCTAssertEqual(font.fontName, ".SFUIText")
        XCTAssertEqual(font.pointSize,  UIFont.labelFontSize * 0.6)
        XCTAssertEqual(color, UIColor(rgba:"#000000FF"))
    }
    
    func testAttributedAuthorTextSuccess() {
        
        let author = self.presenter.attributedAuthor
        
        XCTAssertEqual(author?.string, "testing")
    }
    
    func testAttributedAuthorFormatSuccess() {
        
        guard let author = self.presenter.attributedAuthor,
            let font = author.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont,
            let color = author.attribute(NSForegroundColorAttributeName, at:0, effectiveRange: nil) as? UIColor else
        {
            XCTFail()
            return
        }
        
        XCTAssertEqual(font.fontName, ".SFUIText-Semibold")
        XCTAssertEqual(font.pointSize,  UIFont.labelFontSize * 0.8)
        XCTAssertEqual(color, UIColor(rgba:"#000000FF"))
    }
    
    func testAttributedDateTextSuccess() {
        
        let date = self.presenter.attributedDate
        
        XCTAssertEqual(date?.string, "Thursday, May 4 2017 13:39")
    }
    
    func testAttributedDateFormatSuccess() {
        
        guard let date = self.presenter.attributedDate,
            let font = date.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont,
            let color = date.attribute(NSForegroundColorAttributeName, at:0, effectiveRange: nil) as? UIColor else
        {
            XCTFail()
            return
        }
        
        XCTAssertEqual(font.fontName, ".SFUIText")
        XCTAssertEqual(font.pointSize,  UIFont.labelFontSize * 0.6)
        XCTAssertEqual(color, UIColor(rgba:"#838383FF"))
    }
    
    func testAttributedSubredditTextSuccess() {
        
        let subreddit = self.presenter.attributedSubreddit
        
        XCTAssertEqual(subreddit?.string, "PICS")
    }
    
    func testAttributedSubredditFormatSuccess() {
        
        guard let subreddit = self.presenter.attributedSubreddit,
            let font = subreddit.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont,
            let color = subreddit.attribute(NSForegroundColorAttributeName, at:0, effectiveRange: nil) as? UIColor else
        {
            XCTFail()
            return
        }
        
        XCTAssertEqual(font.fontName, ".SFUIText-Semibold")
        XCTAssertEqual(font.pointSize,  UIFont.labelFontSize * 0.6)
        XCTAssertEqual(color, UIColor(rgba:"#f45042FF"))
    }
}
