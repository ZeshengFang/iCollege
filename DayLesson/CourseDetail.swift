//
//  CourseDetail.swift
//  DayLesson
//
//  Created by fzs on 16/5/12.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import AVOSCloud


class CourseDetail {
    private var _courseDescription:String = "无课程详情"
    private var _date:String!
    private var _imageFile: AVFile!
    private var _commentArray: [String]!
    private var _courseUrl: String!
    private var _ID: String!
    
    var courseDescription: String {
        return _courseDescription
    }
    var date: String {
        return _date
    }
    var imageFile: AVFile {
        return _imageFile
    }
    var commentArray: [String] {
        return _commentArray
    }
    var courseUrl: String {
        return _courseUrl
    }
    var ID: String {
        return _ID
    }
    
    
    
    private func configuration(object: AVObject) {
        if let description = object["description"] as? String, let imageFile = object["image"] as? AVFile, let commentArray = object["commentArray"] as? [String], let courseUrl = object["courseUrl"] as? String {
            self._courseDescription = description
            self._date = "\(object.updatedAt)".stringByPaddingToLength(10, withString: "", startingAtIndex: 10)
            self._imageFile = imageFile
            self._commentArray = commentArray
            self._courseUrl = courseUrl
            self._ID = object.objectId
        }

    }
    
    init(object: AVObject) {
        configuration(object)
    }
    
    
}