//
//  NormalTextField.swift
//  DayLesson
//
//  Created by fzs on 16/5/7.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class NormalTextField: UITextField, UITextFieldDelegate  {


    override func awakeFromNib() {
        
        self.delegate = self
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
