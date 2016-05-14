//
//  ViewController.swift
//  LimitCharacters
//
//  Created by Allen on 16/1/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import Cosmos
import MaterialKit
import AVOSCloud
class CommentViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: BorderTextView!
    @IBOutlet weak var bottomUIView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    var courseID: String!
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        
       // avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        
        tweetTextView.backgroundColor = UIColor.clearColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyBoardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let myTextViewString = tweetTextView.text
        characterCountLabel.text = "\(140 - myTextViewString.characters.count)"
        
        if range.length > 140{
            return false
        }
        
        let newLength = (myTextViewString?.characters.count)! + range.length
        
        return newLength < 140
        
        
        
    }
    
    func keyBoardWillShow(note:NSNotification) {
        
        let userInfo  = note.userInfo
        let keyBoardBounds = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            
           // self.bottomUIView.transform = CGAffineTransformMakeTranslation(0,-deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else {
            
            animations()
        }
        
    }
    
    
    func keyBoardWillHide(note:NSNotification) {
        
        let userInfo  = note.userInfo
        let duration = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            
            //self.bottomUIView.transform = CGAffineTransformIdentity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
            
            UIView.animateWithDuration(duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            
            animations()
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }

    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postComment(sender: MKButton) {
        guard ratingView.rating > 0  && tweetTextView.text != nil && tweetTextView.text != "" else {
            let sweetAlert = SweetAlert()
            sweetAlert.kMaxHeight = UIScreen.mainScreen().bounds.height / 2
            sweetAlert.showAlert("评论失败", subTitle: "评分或评论不能为空", style: AlertStyle.Error)
            return
        }
        
        let comment = AVObject(className:"Comment")
        comment["rating"] = ratingView.rating
        comment["commentContent"] = tweetTextView.text
        comment["userID"] = AVUser.currentUser().objectId
        comment["courseID"] = courseID
        comment.saveInBackgroundWithBlock { (result, error) -> Void in
            if result {
                let sweetAlert = SweetAlert()
                sweetAlert.showAlert("评论成功", subTitle: "", style: AlertStyle.Success)
            }
        }
        
        
        
    }

}

