//
//  RedditCellView.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/5/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import UIKit

class RedditCellView: UITableViewCell {
    
    @IBOutlet var thumbnail: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var authorLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var commentCntLabel: UILabel?
    @IBOutlet var subredditLabel: UILabel?
    @IBOutlet var spinner: UIActivityIndicatorView?
    
    weak var task: URLSessionDataTask?
    
    override func prepareForReuse() {
        self.thumbnail?.image = nil
        
        super.prepareForReuse()

        guard let task = self.task else { return }
        
        task.cancel()
        
    }
}
