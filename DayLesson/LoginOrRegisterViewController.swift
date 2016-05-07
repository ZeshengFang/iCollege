//
//  LoginOrRegisterViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/21.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud

class LoginOrRegisterViewController: UIViewController {

    @IBOutlet weak var acountTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let testUser = AVUser()
//        let error = NSErrorPointer()
//        testUser.username = "Test"
//        testUser.password = "Test"
//        testUser.signUp(error)
        
    }

    
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.acountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }

    

    
    
    @IBAction func login(sender: UIButton) {
        guard let acountText = acountTextField.text where acountText != "" else {
            return
        }
        guard let passwordText = passwordTextField.text where passwordText != "" else {
            return
        }
        loginWhitAVUser(acountText, passwordText: passwordText)
    }
    
    private func loginWhitAVUser(acountText: String, passwordText: String) {
        
        AVUser.logInWithUsernameInBackground(acountText, password: passwordText){ (user, error) -> Void in
            if let error = error {
                print(error.debugDescription)
                
            } else {
                print("sucess")
                self.dismissViewControllerAnimated(false, completion: nil)
            }
           }

    }
}
