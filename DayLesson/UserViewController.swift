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

    @IBOutlet weak var loginOrLogOutButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.scrollEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if AVUser.currentUser() != nil {
            loginOrLogOutButton.setTitle("退出登录", forState: .Normal)
        } else {
            loginOrLogOutButton.setTitle("登录", forState: .Normal)
        }
    }

    
    
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
                    destination.which = 1
                }
            }
        }
    }
    
    
    @IBAction func loginOrlogOut() {
        
        if AVUser.currentUser() != nil {
            AVUser.logOut()
            loginOrLogOutButton.setTitle("登录", forState: .Normal)
        } else {
            loginOrLogOutButton.setTitle("退出登录", forState: .Normal)
            self.performSegueWithIdentifier(Storyboard.segue_login, sender: nil)
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
                if let collectionCourseID = user["collectionCourse"] as? [Int] {
                    self.performSegueWithIdentifier(Storyboard.segue_userToSearch, sender: collectionCourseID)
                }
                
            case 1: break
            case 2: break
            case 3: break
            default: break
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}