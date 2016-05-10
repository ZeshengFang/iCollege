//
//  CourseDdtailViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/10.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CourseDdtailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80.0
            tableView.rowHeight = UITableViewAutomaticDimension
        }
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