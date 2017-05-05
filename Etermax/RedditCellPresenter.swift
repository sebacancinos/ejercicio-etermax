//
//  RedditCellPresenter.swift
//  Etermax
//
//  Created by Sebastian Cancinos on 5/5/17.
//  Copyright © 2017 Etermax. All rights reserved.
//

import UIKit

class RedditCellPresenter: NSObject {
    
    let link: RedditLink
    
    init(forLink link: RedditLink) {
        self.link = link
    }
    
    func presentThumbnailIn( imageView: UIImageView, whileShowing spinner: UIActivityIndicatorView) -> URLSessionDataTask? {
        
        guard let thumbURL = self.link.thumbnail,
            let url = URL(string: thumbURL) else { return nil}
        
        spinner.startAnimating()
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let imageData = data, let image = UIImage.init(data: imageData)
                    else{
                        DispatchQueue.main.async(execute: {
                            imageView.image = #imageLiteral(resourceName: "notfound")
                            spinner.stopAnimating()
                        })
                        
                        return  }
            
            DispatchQueue.main.async(execute: {
                spinner.stopAnimating()
                imageView.image = image
            })
        }
        
        task.resume()

        return task
    }
    
    var attributedTitle : NSAttributedString? {
        
        return NSAttributedString(string:self.link.title, attributes:[
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: UIFont.labelFontSize * 1.2),
            NSForegroundColorAttributeName: UIColor(rgba:"#2d528eFF")])
    }
    
    var attributedDate: NSAttributedString? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d yyyy HH:mm"
        
        let formatedDate = formatter.string(from: self.link.date)

        return NSAttributedString(string:formatedDate, attributes:[
            NSFontAttributeName : UIFont.systemFont(ofSize: UIFont.labelFontSize * 0.6),
            NSForegroundColorAttributeName: UIColor(rgba:"#838383FF")])
        
    }
    
    var attributedAuthor: NSAttributedString? {
        
        return NSAttributedString(string:self.link.author, attributes:[
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: UIFont.labelFontSize * 0.8),
            NSForegroundColorAttributeName: UIColor(rgba:"#000000FF")])
    }

    var attributedComments: NSAttributedString? {
        
        return NSAttributedString(string:"\(self.link.commentCnt) comments", attributes:[
            NSFontAttributeName : UIFont.systemFont(ofSize: UIFont.labelFontSize * 0.6),
            NSForegroundColorAttributeName: UIColor(rgba:"#000000FF")])
    }

    var attributedSubreddit: NSAttributedString? {
        
        return NSAttributedString(string:self.link.subReddit.uppercased(), attributes:[
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: UIFont.labelFontSize * 0.6),
            NSForegroundColorAttributeName: UIColor(rgba:"#f45042FF")])
    }

    

}
