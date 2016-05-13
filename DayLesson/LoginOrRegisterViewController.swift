//
//  LoginOrRegisterViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/21.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud
import BubbleTransition
import TKSubmitTransition

class LoginOrRegisterViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var acountTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginButton: TKTransitionSubmitButton!
    @IBOutlet weak var unLOginUserEntranceButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    let transition = BubbleTransition()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = loginButton.center
        transition.bubbleColor = loginButton.backgroundColor!
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = loginButton.center
        transition.bubbleColor = loginButton.backgroundColor!
        return transition
    }
    

    
    @IBAction func dismissKeyboard() {
        self.acountTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    var state = true
    @IBAction func signUp(sender: UIButton) {
        unLOginUserEntranceButton.hidden = !unLOginUserEntranceButton.hidden
        let title = sender.titleLabel?.text
        sender.setTitle(loginButton.titleLabel?.text, forState: .Normal)
        loginButton.setTitle(title, forState: .Normal)
        state = !state
        if state {
            textLabel.text = "新用户"
        } else {
            textLabel.text = "已有账户"
        }
        
    }
    

    
    
    @IBAction func login(sender: TKTransitionSubmitButton) {
        
        dismissKeyboard()
        guard let acountText = acountTextField.text where acountText != "" else {
            return
        }
        guard let passwordText = passwordTextField.text where passwordText != "" else {
            return
        }
        sender.startLoadingAnimation()
        
        if state {
            loginWhitAVUser(acountText, passwordText: passwordText, btn: sender)
        } else {
            signUp(acountText, passwordText: passwordText, btn: sender)
        }
    }
    
    private func loginWhitAVUser(acountText: String, passwordText: String, btn: TKTransitionSubmitButton) {
        AVUser.logInWithUsernameInBackground(acountText, password: passwordText){ (user, error) -> Void in
            if let error = error {
                print(error.debugDescription)
                btn.setOriginalState()
            } else {
                print("sucess")
                self.performSegueWithIdentifier(Storyboard.segue_loginToHome, sender: nil)
                
            }
        }
    }
    
    private func signUp(acountText: String, passwordText: String, btn: TKTransitionSubmitButton) {
        let user = AVUser()
        user.username = acountText
        user.password = passwordText
        user.signUpInBackgroundWithBlock { (state, error) -> Void in
            if error == nil {
                 SweetAlert().showAlert("成功注册!", subTitle: "", style: AlertStyle.Success)
            } else {
                SweetAlert().showAlert("注册失败!", subTitle: "", style: AlertStyle.Error)
                print(error)
            }
            btn.setOriginalState()
        }
        

    }
}
