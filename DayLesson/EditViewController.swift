//
//  EditViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/7.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud
import NVActivityIndicatorView

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var nameTextField: NormalTextField!
    
    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityView: NVActivityIndicatorView!
    
    var sexIsMale: Bool = true
    var name: String = "Mark Price"

    var image: UIImage!
    
    var isImageSet = false
    
    let user = AVUser.currentUser()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    private func setUp() {

//        guard name != nil else {
//            return
//        }
//        guard imageName != nil else {
//            return
//        }
        nameTextField.text = name
        if image != nil {
            imageView.image = image
            isImageSet = true
        }
        
        
        if let sex = user["sex"] as? String {
            if sex == "male" {
                sexIsMale = true
            } else {
                sexIsMale = false
            }
        }
        if !sexIsMale {
            switchBcakgroundColor(maleButton, femaleButton: femaleButton)
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if isImageSet {
            //设置图片后隐藏默认图片
            addImageButton.setImage(UIImage(named: ""), forState: .Normal)
        }
    }

    @IBAction func postUserInfo() {
        coverView.hidden = false
        activityView.startAnimation()
        if sexIsMale {
            user["sex"] = "male"
        } else {
            user["sex"] = "female"
        }
        user["name"] = nameTextField.text
        user["image"] = AVFile(data: UIImageJPEGRepresentation(imageView.image!, 0.3))
        user.saveInBackgroundWithBlock { (success, error) -> Void in
            print("ok")
            self.image = self.imageView.image
            self.name = self.user["name"] as! String
            self.coverView.hidden = true
            self.activityView.stopAnimation()
            SweetAlert().showAlert("保存成功", subTitle: "", style: AlertStyle.Success)
        }
    }

    @IBAction func addImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion:
                nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            //设置图片后隐藏默认图片
            addImageButton.setImage(UIImage(named: ""), forState: .Normal)
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func confirm(sender: AnyObject) {
    }
    @IBAction func clickMaleButton() {
        sexIsMale = true
        switchBcakgroundColor(maleButton, femaleButton: femaleButton)
        
    }

    @IBAction func clickFemaleButton() {
        sexIsMale = false
        switchBcakgroundColor(maleButton, femaleButton: femaleButton)
    }
    
    
    private func switchBcakgroundColor(maleButton: UIButton, femaleButton: UIButton) {
        let backgroundColor = maleButton.backgroundColor
        maleButton.backgroundColor = femaleButton.backgroundColor
        femaleButton.backgroundColor = backgroundColor
    }


}
