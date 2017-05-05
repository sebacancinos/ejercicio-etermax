//
//  RedditDataSource.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/5/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import Foundation
import UIKit

class RedditDataSource: NSObject, UITableViewDataSource {
    
    var listing : RedditListing?
    var updating: Bool
    
    @IBOutlet weak var table: UITableView?
    
    override init() {
        self.updating = false

        super.init()
        self.getListing()
    }
    
    func getListing() {
        if self.updating { return }

        self.updating = true
        let future = RedditRepository().retrieveTop()
        future.start() { result in
            self.updating = false
            guard case .success(let entity as RedditListing) = result else {
                return
            }
            
            self.listing = entity
            
            if let table = self.table {
                table.reloadData()
            }
        }
    }
    
    func getNextPage() {
        if self.updating { return }
        
        self.updating = true
        guard let after = self.listing?.after else { return }
        
        let future = RedditRepository().retrieveTop(withLimit: 25, after)
        future.start() { result in
            self.updating = false

            guard case .success(let entity as RedditListing) = result else {
                return
            }
            
            self.listing = self.listing?.append(entity)
            
            if let table = self.table {
                table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let listing = self.listing {
            return listing.children.count
        } 
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditCellIdentifier", for: indexPath) as! RedditCellView

        guard let link = self.listing?.children[indexPath.row] as? RedditLink else { return cell }
        
        let presenter = RedditCellPresenter(forLink: link)
        
        cell.task = presenter.presentThumbnailIn(imageView: cell.thumbnail!, whileShowing: cell.spinner!)
        cell.titleLabel?.attributedText = presenter.attributedTitle
        cell.dateLabel?.attributedText = presenter.attributedDate
        cell.authorLabel?.attributedText = presenter.attributedAuthor
        cell.commentCntLabel?.attributedText = presenter.attributedComments
        cell.subredditLabel?.attributedText = presenter.attributedSubreddit

        return cell
    }
}
