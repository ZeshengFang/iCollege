//
//  TabBarViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/22.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBInspectable var barItemSelectedColor: UIColor!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let items = self.tabBar.items else {
            return 
            
        }
        for item in items {
            item.setTitleTextAttributes([NSForegroundColorAttributeName: barItemSelectedColor], forState: .Selected)
            
        }
    }


}
