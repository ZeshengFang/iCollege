//
//  issueViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/9.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import DOFavoriteButton

class IssueViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 180.0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    var articles = learnCloud.getArticles()
    override func viewDidLoad() {
    }
    
}





extension IssueViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.issueCellIdentifier) as! issueCell
        cell.configuration(articles[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}