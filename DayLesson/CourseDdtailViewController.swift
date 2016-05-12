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
        }
    }
    
    var introduction: Introduction!{
        didSet {
            courseDetail = learnCloud.gerCourseDetailWithID(introduction.descriptionObjectID)
        }
    }
    var courseDetail: CourseDetail! {
        didSet {
            courseDetail.imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                self.authorImage.image = UIImage(data: data)
            }
        }
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
            break
        case 1:
            self.performSegueWithIdentifier(Storyboard.segue_courseDetailToComment, sender: nil)
        case 2:
            let webVC = SFSafariViewController(URL: NSURL(string: url)!)
            webVC.delegate = self
            self.presentViewController(webVC, animated: true, completion: nil)
        default: break
        }
        
        liquidFloatingActionButton.close()
    }
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        //self.dismissViewControllerAnimated(true, completion: nil)
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
        cells.append(cellFactory("ic_cloud"))
        cells.append(cellFactory("ic_system"))
        cells.append(cellFactory("ic_place"))
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 40, height: 40)
        let bottomRightButton = createButton(floatingFrame, .Up)
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
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.introductionCellIdentifier) as? IntroductionTableViewCell
        
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
            return cell
        }
        
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
}