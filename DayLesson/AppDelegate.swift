//
//  AppDelegate.swift
//  DayLesson
//
//  Created by fzs on 16/2/16.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud
let story = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var introductions = [Introduction]()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        AVOSCloud.setApplicationId("ODlb4v6CMGChWJFLv1AcRxiz-gzGzoHsz", clientKey: "KLYzANhKqfaBWEU2xp8MKhHl")
       // changeNavigationBarAppearance()
        chageStatusBarStyle()
        
        
        
        if AVUser.currentUser() != nil {
            
            if let viweController =  story.instantiateViewControllerWithIdentifier(Storyboard.viewControllerStoryBoardID_tabbar) as? TabBarViewController {
                window?.rootViewController = viweController
            }
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    func changeNavigationBarAppearance() {
    
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        if let barFont = UIFont(name: "Avenir-Light", size: 20.0) {
            UINavigationBar.appearance().titleTextAttributes =
                [NSForegroundColorAttributeName:UIColor.whiteColor(),
                    NSFontAttributeName:barFont]
        }
        
       

    }
    
    func chageStatusBarStyle() {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
    }
    
    
    

}

