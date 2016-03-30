//
//  HomePageViewController.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud
import WebKit
@IBDesignable
class HomePageViewController: UIViewController {

    @IBInspectable var startColor: UIColor = UIColor.whiteColor()
    @IBInspectable var midClor: UIColor = UIColor.whiteColor()
    @IBInspectable var endColor: UIColor = UIColor.whiteColor()
    
    // MARK: - storyboard outlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.addSubview(tableViewRefreshController)
            tableView.tableFooterView = UIView(frame: CGRectZero)
        }
    }
   
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
        }
    }
    
    var introductionLists = [Introduction]() {
        didSet {
             tableView?.reloadData()
        }
    }
    var LearnCloudIntroductions = [Introduction]()
    var defaultIntroductions = [Introduction]()
    var decreaseCollectionsIntroductions = [Introduction]()
    var increaseCollectionsIntroductions = [Introduction]()
    
    
    var callRefreshTimes = 0
    
    lazy var tableViewRefreshController: UIRefreshControl = {
        let refreshContrller = UIRefreshControl()
        refreshContrller.attributedTitle =  NSAttributedString(string: "加载中")
        refreshContrller.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        return refreshContrller
    }()
    
    private struct LeanCloud {
        static let className = "Test"
    }
    
    private struct buttonTag {
        static let defaultButton = 1
        static let collectionButton = 2
    
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
        
        setUp()
        refresh()
        
        
    }
    override func viewWillAppear(animated: Bool) {
        navigationBarAppearanceSetUp()

    }
    private func navigationBarAppearanceSetUp() {
        guard let navigationVC = navigationController else {
            return
        }
        let navigationGradientLayer = CAGradientLayer()
        let fram = CGRectMake(0.0, 0.0, navigationVC.navigationBar.bounds.width, navigationVC.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.height)
        navigationGradientLayer.frame = fram
        navigationGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        navigationGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        navigationGradientLayer.colors = [startColor.CGColor, midClor.CGColor, endColor.CGColor]
        
        
        UIGraphicsBeginImageContext(navigationGradientLayer.bounds.size)
        navigationGradientLayer.renderInContext(UIGraphicsGetCurrentContext()!)
        let gradientBackGround = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        navigationController?.navigationBar.setBackgroundImage(gradientBackGround, forBarMetrics: .Default)
    }
    
    private func setUp() {
        if let currentButton = self.view.viewWithTag(currentButtonTag) as? HomePageLIstButton {
            currentButton.setTitleColor(currentButton.selectTitleColor, forState: .Normal)
        }
        

    }
    func refresh() {
        
        //delete it When do not need
        //当前刷新属于第几次刷新
        let currentTime = ++callRefreshTimes
        //创建从leancloud获取数据的队列
        let query = AVQuery(className: LeanCloud.className)
        //执行完成后执行闭包中的代码
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            //首先清空当前存储网络通信返回的数据的数组
            self.LearnCloudIntroductions.removeAll()
            //if let 语句对判断是否有返回的数据，并且对返回的数据进行解包操作
            if let objects = objects {
                //利用for in 语句将返回的数据转化为Introduction类，转化过程由Introduction类处理
                for object in objects {
                    let introduction = Introduction(sender: object)
                    self.LearnCloudIntroductions.append(introduction)
                }
                //如果没有出错的话
                if error == nil {
                    //判断返回该数据的操作次数是否与当前刷新操作的次数相同且tableViewRefreshController还在刷新或者是不是第一次打开该controller的自动刷新
                     if (self.tableViewRefreshController.refreshing && currentTime == self.callRefreshTimes) || currentTime == 1 {
                        //将以进行赋值操作的LearnCloudIntroductions数组赋值给table view的数据源数组defaultIntroductions，实现来源数据的分离
                        self.defaultIntroductions = self.LearnCloudIntroductions
                        //并且对table view的数据源数组defaultIntroductions使其按照某种方法进行排序
                        self.decreaseCollectionsIntroductions = self.LearnCloudIntroductions.sort{ return $0.collectioons > $1.collectioons }
                        self.increaseCollectionsIntroductions = self.LearnCloudIntroductions.sort{ return $0.collectioons < $1.collectioons }
                        //判断当前的展示方式为哪种，以对展示数组赋以相对应的数组
                        if let button = self.view.viewWithTag(self.currentButtonTag) as? HomePageLIstButton {
                            self.resetInroductionList(button)
                        } else {
                            print("ButtonTag error")
                        }
                        //所有操作完成后停止刷新
                        self.tableViewRefreshController.endRefreshing()
                        self.activityIndicatorView.stopAnimating()
                    }
                } else {
                    // to do
                    self.activityIndicatorView.stopAnimating()
                }
                
                
            }
        }
        
    }
    
    
    
    
    @IBAction func pressesListButton(button: HomePageLIstButton){
        
        button.changeArrowDirection()
        currentButtonTag = button.tag
        if tableViewRefreshController.refreshing {
            tableViewRefreshController.endRefreshing()
        }
        
        
        resetInroductionList(button)
    }
    
    private func resetInroductionList(button: HomePageLIstButton) {
        switch button.tag {
        case buttonTag.defaultButton:
            introductionLists = defaultIntroductions
        case buttonTag.collectionButton:
            introductionLists = button.increase ? increaseCollectionsIntroductions : decreaseCollectionsIntroductions
        default: break
        }
    }
    


    
    
    
    
}








extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - tableViewDataSourse
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return introductionLists.count
    }
    
    private struct Storyboard {
        static let cellIdentifier = "IntroductionCell"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.cellIdentifier) as? IntroductionTableViewCell
        cell!.configurationCell(introductionLists[indexPath.row])
        return cell!
    }
    // MARK: - tableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("CellToVideoVC", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

}
