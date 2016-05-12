//
//  LearnCloud.swift
//  DayLesson
//
//  Created by fzs on 16/5/10.
//  Copyright © 2016年 fzs. All rights reserved.
//

import AVOSCloud
import UIKit
let learnCloud = LearnCloud()
class LearnCloud {

    
    func refresh(className: String, block: AVArrayResultBlock) {
        let query = AVQuery(className: className)
        query.findObjectsInBackgroundWithBlock(block)
    }
    
    func gerCourseDetailWithID(ID: String) -> CourseDetail {
        let obeject = AVQuery.getObjectOfClass("CourseDetail", objectId: ID)
        let courseDetail = CourseDetail(object: obeject)
        return courseDetail
    }
}
