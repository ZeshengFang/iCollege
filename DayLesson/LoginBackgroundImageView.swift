//
//  LoginBackgroundImageView.swift
//  DayLesson
//
//  Created by fzs on 16/3/19.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class LoginBackgroundImageView: UIImageView {
    
    let visualView = UIVisualEffectView()

    override func awakeFromNib() {
        super.awakeFromNib()
        let blurEffect = UIBlurEffect(style: .Dark)
        visualView.alpha = 0.8
        visualView.effect = blurEffect
        self.addSubview(visualView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        visualView.frame = self.bounds
    }

}
