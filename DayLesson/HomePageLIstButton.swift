//
//  HomePageLIstButton.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class HomePageLIstButton: UIButton {
    @IBInspectable var selectTitleColor: UIColor = UIColor.redColor()
    private var arrowDirectionUp = true
    var increase: Bool{
        return arrowDirectionUp
    }
    
    func changeArrowDirection() {
        
        let text = arrowDirectionUp ? self.titleLabel?.text?.stringByReplacingOccurrencesOfString("↑", withString: "↓") : self.titleLabel?.text?.stringByReplacingOccurrencesOfString("↓", withString: "↑")
        self.setTitle(text, forState: .Normal)
        self.setTitleColor(selectTitleColor, forState: .Normal)
        arrowDirectionUp = !arrowDirectionUp
    }
    

}
