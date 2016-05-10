//
//  LearnCloud.swift
//  DayLesson
//
//  Created by fzs on 16/5/10.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import AVOSCloud

class LearnCloud {


    func refresh(className: String, block: AVArrayResultBlock) {
        let query = AVQuery(className: className)
        query.findObjectsInBackgroundWithBlock(block)
    }
}
