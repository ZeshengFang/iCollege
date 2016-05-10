//
//  HomePageViewController.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud
import NVActivityIndicatorView
import DGElasticPullToRefresh
import MaterialKit
import WebKit
var LearnCloudIntroductions = [Introduction]()
@IBDesignable
class HomePageViewController: UIViewController {

    //******
    @IBInspectable var startColor: UIColor = UIColor.whiteColor()
    @IBInspectable var midClor: UIColor = UIColor.whiteColor()
    @IBInspectable var endColor: UIColor = UIColor.whiteColor()
    
    // MARK: - storyboard outlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            //tableView.addSubview(tableViewRefreshController)
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
    
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView! {
        didSet {
            activityIndicatorView.type = .BallSpinFadeLoader
            activityIndicatorView.startAnimation()
        }
    }
   
    
    var introductionLists = [Introduction]() {
        didSet {
             tableView?.reloadData()
        }
    }
    
    //并且对table view的数据源数组defaultIntroductions使其按照某种方法进行排序
    var decreaseCollectionsIntroductions = [Introduction]()
    var increaseCollectionsIntroductions = [Introduction]()
    var decreaseCommentCountIntroductions = [Introduction]()
    var increaseCommentCountIntroductions = [Introduction]()
    var decreaseRatingIntroductions = [Introduction]()
    var increaseRatingIntroductions = [Introduction]()
    var defaultIntroductions = [Introduction]() {
        didSet {
            decreaseCollectionsIntroductions = defaultIntroductions.sort{ return $0.collections >= $1.collections }
            increaseCollectionsIntroductions = defaultIntroductions.sort{ return $0.collections <= $1.collections }
            decreaseCommentCountIntroductions = defaultIntroductions.sort{return $0.commentCount >= $1.commentCount}
            increaseCommentCountIntroductions = defaultIntroductions.sort{return $0.commentCount <= $1.commentCount}
            decreaseRatingIntroductions = defaultIntroductions.sort{return $0.rating >= $1.rating}
            increaseRatingIntroductions = defaultIntroductions.sort{return $0.rating <= $1.rating}
        }
    }

    
    var callRefreshTimes = 0
    
    let refreshControl = MKRefreshControl()
    //******
//    lazy var tableViewRefreshController: UIRefreshControl = {
//        let refreshContrller = UIRefreshControl()
//        refreshContrller.attributedTitle =  NSAttributedString(string: "加载中")
//        //****
//        refreshContrller.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
//        return refreshContrller
//    }()
    
    

    
    let learnCloud = LearnCloud()
    
    
    private struct LeanCloud {
        static let className = "Test"
    }
    
    private struct buttonTag {
        static let defaultButton = 1
        static let collectionButton = 2
        static let commentCountButton = 3
        static let ratingButton = 4
    
    }
    private var currentButtonTag = buttonTag.defaultButton {
        willSet {
            if newValue != currentButtonTag {
                if let previousButton = self.view.viewWithTag(currentButtonTag) as? HomePageLIstButton {
                    previousButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                }
            }
        }
    }
    
    
    

    
    
    // MARK: - viewLifecycle
    override func viewDidLoad() {
        

//        let inss = AVObject(className: "Test")
//        inss["name"] = "zz"
//        inss["author"] = "xx"
//        inss["collections"] = 11
//        
//        inss.saveInBackground()
        let block:AVArrayResultBlock = {[unowned self] (objects, error) -> Void in
            //let currentTime = ++self.callRefreshTimes
            //首先清空当前存储网络通信返回的数据的数组
            LearnCloudIntroductions.removeAll()
            //if let 语句对判断是否有返回的数据，并且对返回的数据进行解包操作
            if let objects = objects {
                //利用for in 语句将返回的数据转化为Introduction类，转化过程由Introduction类处理
                for object in objects {
                    let introduction = Introduction(sender: object)
                    LearnCloudIntroductions.append(introduction)
                }
                //如果没有出错的话
                if error == nil {
                    //判断返回该数据的操作次数是否与当前刷新操作的次数相同且tableViewRefreshController还在刷新或者是不是第一次打开该controller的自动刷新
                    //if (self.tableViewRefreshController.refreshing && currentTime == self.callRefreshTimes) || currentTime == 1 {
                        //将以进行赋值操作的LearnCloudIntroductions数组赋值给table view的数据源数组defaultIntroductions，实现来源数据的分离
                        self.defaultIntroductions = LearnCloudIntroductions
                        //判断当前的展示方式为哪种，以对展示数组赋以相对应的数组
                        if let button = self.view.viewWithTag(self.currentButtonTag) as? HomePageLIstButton {
                            self.setInroductionList(button)
                        } else {
                            print("ButtonTag error")
                        }
                        //所有操作完成后停止刷新
                        //self.tableViewRefreshController.endRefreshing()
                        self.activityIndicatorView.stopAnimation()
                    if self.refreshControl.refreshing {
                         self.refreshControl.endRefreshing()
                    }
                    
                    //}
                } else {
                    // to do
                    self.activityIndicatorView.stopAnimation()
                }
                
                
            }
        }

        
        setUp()
        learnCloud.refresh(LeanCloud.className, block: block)

        
        refreshControl.addToScrollView(self.tableView, withRefreshBlock: { [unowned self]() -> Void in
            self.learnCloud.refresh(LeanCloud.className, block: block)
            
        })
//        refreshControl.beginRefreshing()
        
    }
//    override func viewWillAppear(animated: Bool) {
//        navigationBarAppearanceSetUp()
//
//    }
//    private func navigationBarAppearanceSetUp() {
//        guard let navigationVC = navigationController else {
//            return
//        }
//        let navigationGradientLayer = CAGradientLayer()
//        let fram = CGRectMake(0.0, 0.0, navigationVC.navigationBar.bounds.width, navigationVC.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.height)
//        navigationGradientLayer.frame = fram
//        navigationGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        navigationGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        navigationGradientLayer.colors = [startColor.CGColor, midClor.CGColor, endColor.CGColor]
//        
//        
//        UIGraphicsBeginImageContext(navigationGradientLayer.bounds.size)
//        navigationGradientLayer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let gradientBackGround = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        
//        navigationController?.navigationBar.setBackgroundImage(gradientBackGround, forBarMetrics: .Default)
//    }
    
    private func setUp() {
        if let currentButton = self.view.viewWithTag(currentButtonTag) as? HomePageLIstButton {
            currentButton.setTitleColor(currentButton.selectTitleColor, forState: .Normal)
        }
        

    }
//    func refresh(block: AVArrayResultBlock) {
//        
//        //delete it When do not need
//        //当前刷新属于第几次刷新
//        
//        //创建从leancloud获取数据的队列
//        let query = AVQuery(className: LeanCloud.className)
//        //执行完成后执行闭包中的代码
//        query.findObjectsInBackgroundWithBlock(block)
//        //query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
////            //首先清空当前存储网络通信返回的数据的数组
////            LearnCloud.LearnCloudIntroductions.removeAll()
////            //if let 语句对判断是否有返回的数据，并且对返回的数据进行解包操作
////            if let objects = objects {
////                //利用for in 语句将返回的数据转化为Introduction类，转化过程由Introduction类处理
////                for object in objects {
////                    let introduction = Introduction(sender: object)
////                    LearnCloud.LearnCloudIntroductions.append(introduction)
////                }
////                //如果没有出错的话
////                if error == nil {
////                    //判断返回该数据的操作次数是否与当前刷新操作的次数相同且tableViewRefreshController还在刷新或者是不是第一次打开该controller的自动刷新
////                     if (self.tableViewRefreshController.refreshing && currentTime == self.callRefreshTimes) || currentTime == 1 {
////                        //将以进行赋值操作的LearnCloudIntroductions数组赋值给table view的数据源数组defaultIntroductions，实现来源数据的分离
////                        HomePageViewController.defaultIntroductions = LearnCloud.LearnCloudIntroductions
////                        
////                       
////                        //判断当前的展示方式为哪种，以对展示数组赋以相对应的数组
////                        if let button = self.view.viewWithTag(self.currentButtonTag) as? HomePageLIstButton {
////                            self.setInroductionList(button)
////                        } else {
////                            print("ButtonTag error")
////                        }
////                        //所有操作完成后停止刷新
////                        self.tableViewRefreshController.endRefreshing()
////                        self.activityIndicatorView.stopAnimation()
////                    }
////                } else {
////                    // to do
////                    self.activityIndicatorView.stopAnimation()
////                }
////                
////                
////            }
//        
//        
//    }
    
    
    
    
    @IBAction func pressesListButton(button: HomePageLIstButton){
        
        button.changeArrowDirection()
        currentButtonTag = button.tag
//        if tableViewRefreshController.refreshing {
//            tableViewRefreshController.endRefreshing()
//        }
        
        
        setInroductionList(button)
    }
    
    private func setInroductionList(button: HomePageLIstButton) {
        switch button.tag {
        case buttonTag.defaultButton:
            introductionLists = defaultIntroductions
        case buttonTag.collectionButton:
            introductionLists = button.increase ? increaseCollectionsIntroductions : decreaseCollectionsIntroductions
        case buttonTag.commentCountButton:
            introductionLists = button.increase ? increaseCommentCountIntroductions : decreaseCommentCountIntroductions
        case buttonTag.ratingButton:
            introductionLists = button.increase ? increaseRatingIntroductions : decreaseRatingIntroductions
        default: break
        }
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HomeToSearch" {
            if let destination = segue.destinationViewController as? SearchViewController {
                destination.introductions = self.introductionLists
            }
        }
    }
    
    
    
    
}







//****
extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - tableViewDataSourse
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return introductionLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.introductionCellIdentifier) as? IntroductionTableViewCell
        cell!.configurationCell(introductionLists[indexPath.row])
        return cell!
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("CellToVideoVC", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

}
