//
//  CommentCell.swift
//  DayLesson
//
//  Created by fzs on 16/5/11.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import Cosmos

class CommentCell: UITableViewCell {


    @IBOutlet weak var roundImageView: CornerRoundImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentContentTextLabel: UILabel!
}
