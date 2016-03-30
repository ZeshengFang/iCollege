//
//  UserViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/23.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}