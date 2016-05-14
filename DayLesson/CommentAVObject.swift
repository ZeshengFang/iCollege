//
//  CommentAVObject.swift
//  DayLesson
//
//  Created by fzs on 16/5/14.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import AVOSCloud

let kcommentContent: String = "commentContent"
let krating: String = "rating"
let kuserID: String = "userID"
let kcourseID: String = "courseID"


class CommentAVObject: AVObject, AVSubclassing {
    
     var userID: String?
    
     var commentContent: String?
    
     var rating: Double?
    
     var courseID: String?
    
    
    static func parseClassName() -> String! {
        return "Comment"
    }
}