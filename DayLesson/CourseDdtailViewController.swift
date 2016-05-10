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



class CourseDdtailViewController: UIViewController, LiquidFloatingActionButtonDelegate,LiquidFloatingActionButtonDataSource,SFSafariViewControllerDelegate {
    

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80.0
            tableView.rowHeight = UITableViewAutomaticDimension
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
        
       
        print("did Tapped! \(index)")
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
            cell.textLabel?.text = "本课程从最基本的概念开始讲起，步步深入，带领大家学习HTML、CSS样式基础知识，了解各种常用标签的意义以及基本用法，后半部分讲解CSS样式代码添加，为后面的案例课程打下基础。"
            cell.textLabel?.numberOfLines = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.commetTitleCell) as! CommentTitleCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.commentCell) as! CommentCell
            return cell
        }
        
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("CellToVideoVC", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
}