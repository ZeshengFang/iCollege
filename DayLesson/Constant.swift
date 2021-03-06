//
//  Constant.swift
//  DayLesson
//
//  Created by fzs on 16/5/8.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let introductionCellIdentifier = "IntroductionCell"
    static let issueCellIdentifier = "issueCell"
    static let commetTitleCell = "commetTitle"
    static  let commentCell = "comment"
    
    
    
    static let segue_loginToHome = "loginToHome"
    static let segue_userToSearch = "userToSearch"
    static let segue_homeToSearch = "HomeToSearch"
    static let segue_login = "loginSegue"
    static let segue_userToEdit = "userToEdit"
    static let segue_homeToCourseDetail = "homeToCourseDetail"
    static let segue_courseDetailToComment = "courseDetailToComment"
    static let segue_searchToDetail = "SearchToDetail"
    
    static let viewControllerStoryBoardID_tabbar = "tabbarViewController"
    static let viewControllerStoryBoardID_comment = "CommentViewController"
    static let viewControllerStoryBoardID_courseDetail = "CourseDetail"
    

    
}
struct defaultImage {
    static let courseIntroductionImage = "shili1"
    static let userImage = "默认头像"
}




