//
//  CommentCell.swift
//  DayLesson
//
//  Created by fzs on 16/5/11.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import Cosmos
import AVOSCloud

class CommentCell: UITableViewCell {


    @IBOutlet weak var roundImageView: CornerRoundImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentContentTextLabel: UILabel!
    
    
    func configuration(obeject: Comment) {
        let user = learnCloud.getUserWithID(obeject.userID)
        if let imageFile = user["image"] as? AVFile, let name = user["name"] as? String {
            imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                self.roundImageView.image = UIImage(data: data)
            })
            nameLabel.text = name
        } else {
            roundImageView.image = UIImage(named: defaultImage.userImage)
        }
        ratingView.rating = obeject.rating
        commentContentTextLabel.text = obeject.commentContent
        dateLabel.text = obeject.date
    }
}
