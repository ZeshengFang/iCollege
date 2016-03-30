//
//  LoginTextField.swift
//  DayLesson
//
//  Created by fzs on 16/3/19.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class LoginTextField: UITextField, UITextFieldDelegate {
    
    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 1.0
            shapeLayer.fillColor = UIColor.whiteColor().CGColor
            shapeLayer.strokeEnd = 1.0
            configurationShapeLayer(shapeLayer)
            self.layer.addSublayer(shapeLayer)
        }
    }
    
    override func awakeFromNib() {
        shapeLayer = CAShapeLayer()
        
        self.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.frame = self.bounds
    }
    
    private func configurationShapeLayer(shapeLayer: CAShapeLayer) {
        let path = UIBezierPath(rect: CGRect(x: self.bounds.minX, y: self.bounds.maxY - 1.0, width: self.bounds.width, height: 1.0))
        shapeLayer.path = path.CGPath
        
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 23, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 23, 0)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
}
