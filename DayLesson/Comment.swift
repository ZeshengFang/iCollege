//
//  Comment.swift
//  DayLesson
//
//  Created by fzs on 16/5/13.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

class Comment {
    
    private var _commentContent: String!
    private var _rating: Double!
    private var _userID: String!
    private var _courseID: String!
    
    var commentContent: String {
        return _commentContent
    }
    var rating: Double {
        return _rating
    }
    var userID: String {
        return _userID
    }
    var courseID: String {
        return _courseID
    }
    

    private func configuration(object: AVObject) {
        if let commentContent = object["commentContent"] as? String, let rating = object["rating"] as? Double, let userID = object["userID"] as? String, let courseID = object["courseID"] as? String {
            self._commentContent = commentContent
            self._rating = rating
            self._courseID = courseID
            self._userID = userID
        }
        
    }
    
    init(object: AVObject) {
        configuration(object)
    }

    
}