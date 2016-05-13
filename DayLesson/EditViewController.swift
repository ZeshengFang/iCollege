//
//  EditViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/7.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var nameTextField: NormalTextField!
    
    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var sexIsMale: Bool = true
    var name: String = "Mark Price"
    var imageName: String = "头像"

    var image: UIImage!
    
    var isImageSet = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    private func setUp() {
        if !sexIsMale {
            switchBcakgroundColor(maleButton, femaleButton: femaleButton)
        }
//        guard name != nil else {
//            return
//        }
//        guard imageName != nil else {
//            return
//        }
        nameTextField.text = name
        if image != nil {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: imageName)
        }
        
        isImageSet = true
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if isImageSet {
            //设置图片后隐藏默认图片
            addImageButton.setImage(UIImage(named: ""), forState: .Normal)
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
