//
//  SearchViewController.swift
//  DayLesson
//
//  Created by fzs on 16/5/8.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud

enum departurePlace {
    case MyCollection
    case RecentBrowse
}
class SearchViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    
    var introductions: [Introduction]!
    
    //根据枚举中设定的值判断出发的控制器，用以改变该控制器的标题
    var whichDeparturePlace: departurePlace!
 
    
    var searchResults: [Introduction] = []
    var searchController: UISearchController! {
        didSet {
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            //searchController.searchBar.barTintColor = UIColor.blackColor()
            //searchController.searchBar.searchBarStyle = .Minimal
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchResults = introductions
        if whichDeparturePlace != nil {
            switch whichDeparturePlace! {
            case .MyCollection: titleLabel.text = "我的收藏"
            case .RecentBrowse: titleLabel.text = "最近浏览"
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if whichDeparturePlace != nil {
            switch whichDeparturePlace! {
            case .MyCollection:
                if let collectionCourse = AVUser.currentUser()["collectionCourse"] as? [Int] {
                    for var i = 0; i < introductions.count; i++ {
                        if !collectionCourse.contains(introductions[i].ID) {
                            introductions.removeAtIndex(i)
                        }
                    }
                }
                tableView.reloadData()
            case .RecentBrowse: titleLabel.text = "最近浏览"
            }
        }
    }
    
    @IBAction func returnToHome(sender: AnyObject) {
        if searchController.active {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == Storyboard.segue_searchToDetail {
            if let destination = segue.destinationViewController as? CourseDdtailViewController {
                destination.introduction = sender as! Introduction
            }
        }
        
    }

}

extension SearchViewController: UISearchResultsUpdating {
    func filterContentForSearchText(searchText: String) {
        searchResults = introductions.filter({ (introduction:Introduction) -> Bool in
            let nameMatch = introduction.courseName.rangeOfString(searchText, options:
                NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
}


extension SearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        }
        
        return introductions.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.introductionCellIdentifier) as? IntroductionTableViewCell
        if searchController.active {
            cell!.configurationCell(searchResults[indexPath.row])
        } else {
            cell!.configurationCell(introductions[indexPath.row])
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sender = searchController.active ? searchResults[indexPath.row] : introductions[indexPath.row]
        print(sender)
        self.performSegueWithIdentifier(Storyboard.segue_searchToDetail, sender: sender)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
