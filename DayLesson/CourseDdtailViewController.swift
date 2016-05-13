//
//  CourseDdtailViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/10.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import LiquidFloatingActionButton
import SafariServices
import Cosmos
import AVOSCloud



class CourseDdtailViewController: UIViewController, LiquidFloatingActionButtonDelegate,LiquidFloatingActionButtonDataSource,SFSafariViewControllerDelegate {
    @IBOutlet weak var authorImage: CornerRoundImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var courseRealseDateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80.0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    var comments: [Comment] = []
    var commentIDArray: [String]!

    var introduction: Introduction!{
        didSet {
            courseDetail = learnCloud.getCourseDetailWithID(introduction.descriptionObjectID)
            commentIDArray = courseDetail.commentArray
            
        }
    }
    var courseDetail: CourseDetail!
    
    override func viewWillAppear(animated: Bool) {
        courseDetail.imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            if error == nil {
                self.authorImage.image = UIImage(data: data)
            }
        }
        if commentIDArray != nil {
            comments.removeAll()
            for ID in commentIDArray {
                let comment = learnCloud.getCommentWithID(ID)
                comments.append(comment)
            }
            self.tableView.reloadData()
        }
        
        url = courseDetail.courseUrl
    }
    
    
    //待修改
    var url: String = "http://www.ted.com/talks/adam_foss_a_prosecutor_s_vision_for_a_better_justice_system"
    
    var cells: [LiquidFloatingCell] = []
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        switch index {
        case 0:
            if AVUser.currentUser() != nil {
                
                if var collectionCourse = AVUser.currentUser()["collectionCourse"] as? [Int] {
                    if !collectionCourse.contains(introduction.ID) {
                        collectionCourse.append(introduction.ID)
                        cells[index].imageView.tintColor = UIColor(red: 86.0 / 255.0, green: 183.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
                    } else {
                        collectionCourse.removeAtIndex(collectionCourse.indexOf(introduction.ID)!)
                        cells[index].imageView.tintColor = UIColor.whiteColor()
                    }
                    AVUser.currentUser()["collectionCourse"] = collectionCourse
                    
                }

            }
        case 1:
            self.performSegueWithIdentifier(Storyboard.segue_courseDetailToComment, sender: nil)
        case 2:
            let webVC = SFSafariViewController(URL: NSURL(string: url)!)
            webVC.delegate = self
            self.presentViewController(webVC, animated: true, completion: nil)
        default: break
            
        }
        
        //liquidFloatingActionButton.close()
    }
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        if AVUser.currentUser() != nil {
            if var recentBrowse = AVUser.currentUser()["recentBrowse"] as? [Int] {
                if !recentBrowse.contains(introduction.ID) {
                    recentBrowse.append(introduction.ID)
                    AVUser.currentUser()["recentBrowse"] = recentBrowse
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            return floatingActionButton
        }
        
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        }
        cells.append(cellFactory("收藏"))
        cells.append(cellFactory("ic_system"))
        cells.append(cellFactory("ic_place"))
        
        if AVUser.currentUser() != nil {
            if let collectionCourse = AVUser.currentUser()["collectionCourse"] as? [Int] {
                if collectionCourse.contains(introduction.ID) {
                    cells.first?.imageView.tintColor = UIColor(red: 86.0 / 255.0, green: 183.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
                }
            }
        }

        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 40, height: 40)
        let bottomRightButton = createButton(floatingFrame, .Up)
        bottomRightButton.color = UIColor(red: 236.0 / 255.0, green: 156 / 255.0, blue: 17.0 / 255.0, alpha: 1.0)
        self.view.addSubview(bottomRightButton)
        setUp()
    }
    
    func setUp() {
        authorNameLabel.text = introduction.author
        courseNameLabel.text = introduction.courseName
        courseRealseDateLabel.text = courseDetail.date
        
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


extension CourseDdtailViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - tableViewDataSourse
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            if let barFont = UIFont(name: "Avenir-Light", size: 10.0) {
                cell.textLabel?.font = barFont
            }
                
            cell.textLabel?.text = courseDetail.courseDescription
            cell.textLabel?.numberOfLines = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.commetTitleCell) as! CommentTitleCell
            cell.starRatingView.rating = introduction.rating
            cell.commentCountLabel.text = "课程评价(\(introduction.commentCount))"
            if introduction.rating > 0 {
                cell.ratingLabel.text = "\(introduction.rating)"
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.commentCell) as! CommentCell
            cell.configuration(comments[indexPath.row - 2])
            return cell
        }
        
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func reloadTableView(comments: [Comment]) {
        let indexPath = NSIndexPath(forRow: comments.count + 2, inSection: 1)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    
}