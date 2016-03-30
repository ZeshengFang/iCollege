//
//  IntroductionTableViewCell.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class IntroductionTableViewCell: UITableViewCell {

    @IBOutlet weak var briefimageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!

    
    func configurationCell(introduction: Introduction) {
        briefimageView.image = introduction.briefImage
        courseNameLabel.text = introduction.courseName
        authorLabel.text = introduction.author
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func awakeFromNib() {
//        self.layer.borderColor = UIColor(red: 18.0 / 255.0, green: 18.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0).CGColor
//        self.layer.borderWidth = 1.0
//        self.layer.cornerRadius = 4.0
    }
    
}
