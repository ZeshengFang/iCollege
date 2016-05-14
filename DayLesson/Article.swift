//
//  Article.swift
//  DayLesson
//
//  Created by fzs on 16/5/14.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

class Article {
    
    private var _authorName: String!
    private var _likeCount: Int!
    private var _image: AVFile!
    private var _content: String!
    private var _date: String!
    private var _likers: [String]!
    private var _ID: String!
    var authorName: String {
        return _authorName
    }
    var likeCount: Int {
        return _likeCount
    }
    var image: AVFile {
        return _image
    }
    var content: String {
        return _content
    }
    var date: String {
        return _date
    }
    var likers: [String] {
        return _likers
    }
    var ID: String {
        return _ID
    }
    
    
    private func configuration(object: AVObject) {
        if let authorName = object["authorName"] as? String, let likeCount = object["likeCount"] as? Int, let image = object["image"] as? AVFile, let content = object["content"] as? String, let likers = object["likers"] as? [String] {
            self._authorName = authorName
            self._likeCount = likeCount
            self._image = image
            self._content = content
            self._date = "\(object.createdAt)".stringByPaddingToLength(16, withString: "", startingAtIndex: 10)
            self._likers = likers
            self._ID = object.objectId
        }
        
    }
    
    init(object: AVObject) {
        configuration(object)
    }
    
    func plusLikeCount(){
        self._likeCount = self._likeCount + 1
        print(self._likeCount)
    }
    
    
}