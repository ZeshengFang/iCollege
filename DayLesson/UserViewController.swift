//
//  UserViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/23.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud

class UserViewController: UIViewController {

    @IBOutlet weak var imageView: CornerRoundImageView!
    @IBOutlet weak var loginOrLogOutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.scrollEnabled = false
        }
    }
    @IBOutlet weak var signInButton: UIButton!
    var image: UIImage!
    var userName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = AVUser.currentUser() {
            loginOrLogOutButton.setTitle("退出登录", forState: .Normal)
            if let imageFile = user["image"] as? AVFile {
                imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if error == nil{
                        self.imageView.image = UIImage(data: data)
                        
                    }
                })
            }
            
            if let imageFile = user["image"] as? AVFile {
                
                imageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if error == nil {
                        self.image = UIImage(data: data)
                         self.imageView.image = self.image
                    }
                })
            }
            
            if let name = user["name"] as? String {
                userName = name
                nameLabel.text = name
            }
           
            
            
        } else {
            loginOrLogOutButton.setTitle("登录", forState: .Normal)
        }
        
        if let signIn = AVUser.currentUser()["signIn"] as? Bool {
            if signIn {
                signInButton.setTitle("已签到", forState: .Normal)
            }
        }
        
        
        
    }

    var currentDeparturePlace: departurePlace!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.segue_userToSearch {
            if let destination = segue.destinationViewController as? SearchViewController {
                if let collectionCouserID = sender as? [Int] {
                    let introductions =  LearnCloudIntroductions.filter({ (introduction) -> Bool in
                        if collectionCouserID.contains(introduction.ID) {
                            return true
                        }
                        return false
                    })
                    print(introductions)
                    destination.introductions = introductions
                    destination.whichDeparturePlace = currentDeparturePlace
                }
            }
        }
        
        if segue.identifier == Storyboard.segue_userToEdit {
            if let destination = segue.destinationViewController as? EditViewController {
                destination.name = userName
                destination.image = image
            }
        }
        
    }
    
    
    @IBAction func loginOrlogOut() {

        if AVUser.currentUser() != nil {
            AVUser.logOut()
            SweetAlert().showAlert("成功退出!", subTitle: "", style: AlertStyle.Success)
            loginOrLogOutButton.setTitle("登录", forState: .Normal)
            imageView.image = UIImage(named: defaultImage.userImage)
        } else {
            loginOrLogOutButton.setTitle("退出登录", forState: .Normal)
            self.performSegueWithIdentifier(Storyboard.segue_login, sender: nil)
        }
       
        
    }
    
    
    @IBAction func checkIn(sender: UIButton) {
        if AVUser.currentUser() != nil {
            sender.setTitle("已签到", forState: .Normal)
            AVUser.currentUser().setObject(1, forKey: "signIn")
            AVUser.currentUser().save()

        }
    }
    
    //点击编辑按钮触发该事件，判读是否存在当前用户，若存在则跳转
    @IBAction func editPersonalInformation() {
        
        if AVUser.currentUser() != nil {
            self.performSegueWithIdentifier(Storyboard.segue_userToEdit, sender: nil)
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if let sourse = segue.sourceViewController as? EditViewController {
            image = sourse.image
            userName = sourse.name
            imageView.image = image
            nameLabel.text = userName
        }
        
        
    }
    

}


extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var text: String!
        switch indexPath.row {
        case 0: text = "我的收藏"
        case 1: text = "最近浏览"
        case 2: text = "我的课程"
        case 3: text = "我的评论"
        default: text = ""
        }
        cell.textLabel?.text = text
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let user = AVUser.currentUser() {
            switch indexPath.row {
            case 0:
                if let courseIDs = user["collectionCourse"] as? [Int] {
                    currentDeparturePlace = departurePlace.MyCollection
                    self.performSegueWithIdentifier(Storyboard.segue_userToSearch, sender: courseIDs)
                }
                
            case 1:
                if let courseIDs = user["recentBrowse"] as? [Int] {
                    currentDeparturePlace = departurePlace.RecentBrowse
                    self.performSegueWithIdentifier(Storyboard.segue_userToSearch, sender: courseIDs)
                }
            case 2: break
            case 3: break
            default: break
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}