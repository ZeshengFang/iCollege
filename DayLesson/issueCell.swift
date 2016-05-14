//
//  issueCell.swift
//  DayLesson
//
//  Created by fzs on 16/5/9.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud

class issueCell: UITableViewCell {
    
    @IBOutlet weak var portraitImageView: CornerRoundImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var status: Bool = false
    var article: Article!
    func configuration(article: Article) {
        likeButton.imageView?.contentMode = .ScaleAspectFit
        article.image.getDataInBackgroundWithBlock { (data, error) -> Void in
            self.portraitImageView.image = UIImage(data: data)
        }
        nameLabel.text = article.authorName
        likeCountLabel.text = "\(article.likeCount)"
        contentLabel.text = article.content
        releaseDateLabel.text = article.date
        
        if let user = AVUser.currentUser() {
            if article.likers.contains(user.objectId) {
                status = true
                setImageOfLikeButton()
            }
            self.article = article
        }
        
    }

    @IBAction func likeClick(sender: UIButton) {
        if AVUser.currentUser() != nil && !status {
            setImageOfLikeButton()
            let articleLearnCloud = learnCloud.getArticleWithID(article.ID)
            if var likers = articleLearnCloud["likers"] as? [String] {
                print(likers)
                likers.append(AVUser.currentUser().objectId)
                
               // articleLearnCloud["likers"] = likers
                article.plusLikeCount()
                //articleLearnCloud["likeCount"] = article.likeCount
                likeCountLabel.text = "\(article.likeCount)"
                articleLearnCloud.setObject( article.likeCount, forKey: "likeCount")
                articleLearnCloud.addObject(AVUser.currentUser().objectId, forKey: "likers")

                articleLearnCloud.saveInBackground()
                status = true
                let articleLearnCloud1 = learnCloud.getArticleWithID(article.ID)
                print(articleLearnCloud1["likers"])
            }
        }

        
        
    }
    
    private func setImageOfLikeButton() {
        likeButton.setImage(UIImage(named: "like-light")!, forState: .Normal)
    }
}
