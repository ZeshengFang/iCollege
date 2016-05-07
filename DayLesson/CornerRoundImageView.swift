//
//  CornerRoundImageView.swift
//  DayLesson
//
//  Created by fzs on 16/3/23.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
@IBDesignable
class CornerRoundImageView: UIImageView {
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor.CGColor
    }

}
