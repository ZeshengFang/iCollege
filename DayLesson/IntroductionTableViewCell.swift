//
//  IntroductionTableViewCell.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import Cosmos
import AVOSCloud

//protocol lazyLoad {
//    func lazyLoadImage()
//}

class IntroductionTableViewCell: UITableViewCell {

    @IBOutlet weak var briefimageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!

    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingAndComment: UIStackView!
    
//    var delegate: lazyLoad!
    func configurationCell(introduction: Introduction) {
        
        introduction.imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            guard error == nil else {
                return
            }
            self.briefimageView.image = UIImage(data: data)!
            //self.delegate.lazyLoadImage()
        }
        
        
        if briefimageView.image == nil {
            briefimageView.image = UIImage(named: defaultImage.courseIntroductionImage)
        }
        courseNameLabel.text = introduction.courseName
        authorLabel.text = introduction.author
        commentLabel.text = "（\(introduction.commentCount)条评论)"
        starRating.rating = introduction.rating
        ratingAndComment.hidden = false
        if introduction.rating > 0 {
            ratingLabel.text = String(stringInterpolationSegment: introduction.rating)
        } else {
            ratingAndComment.hidden = true
        }
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    

    
}
