//
//  HomePageLIstView.swift
//  DayLesson
//
//  Created by fzs on 16/3/19.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class HomePageLIstView: UIView {
    @IBInspectable var viewStartColor:UIColor = UIColor.clearColor()
    @IBInspectable var viewMidColor:UIColor = UIColor.clearColor()
    @IBInspectable var viewEndColor:UIColor = UIColor.clearColor()
//    var gradientLayer: CAGradientLayer! {
//        didSet {
//            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//            gradientLayer.colors = [self.viewStartColor.CGColor, viewMidColor.CGColor, viewEndColor.CGColor]
//            
//            //gradientLayer.opacity = 0.9
//            
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //gradientLayer = CAGradientLayer()
        setUp(self.layer)
        
        
    }
    func setUp(layer: CALayer) {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [self.viewStartColor.CGColor, viewMidColor.CGColor, viewEndColor.CGColor]
    }
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
