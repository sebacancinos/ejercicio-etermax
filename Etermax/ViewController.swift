//
//  ViewController.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/4/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var dataSource: RedditDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Pagination
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nearBottomFactor = CGFloat(1.5)
        let scrollViewHeight = scrollView.bounds.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let bottomInset = scrollView.contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - (scrollViewHeight * nearBottomFactor)
        
        if scrollView.contentOffset.y >= scrollViewBottomOffset {
            dataSource?.getNextPage()
        }
    }
}
