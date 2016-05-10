//
//  BorderTextView.swift
//  DayLesson
//
//  Created by fzs on 16/5/11.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class BorderTextView: UITextView {

    override func awakeFromNib() {
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.0
    }
    
}
