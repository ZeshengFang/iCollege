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

    @IBOutlet weak var postButton: DOFavoriteButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    
}





extension IssueViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.issueCellIdentifier) as! issueCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}