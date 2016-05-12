//
//  Introdution.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import UIKit
import AVOSCloud

class Introduction {
    private var _imageFile: AVFile!
    private var _courseName: String!
    private var _author: String!
    private var _collections: Int!
    private var _rating: Double!
    private var _commentCount: Int!
    private var _ID: Int!
    private var _descriptionObjectID: String!
    
    var courseName: String {
        return _courseName
    }
    var author: String {
        return _author
    }
    var collections: Int {
        return _collections
    }
    var rating: Double {
        return _rating
    }
    var commentCount: Int {
        return _commentCount
    }
    var ID: Int {
        return _ID
    }
    var imageFile: AVFile {
        return _imageFile
    }
    var descriptionObjectID: String {
        return _descriptionObjectID
    }
    
    private func configuration(courseName: String, author: String, collections: Int, rating: Double, commentCount: Int, ID: Int, imageFile: AVFile, descriptionObjectID: String) {
        self._courseName = courseName
        self._author = author
        self._collections = collections
        self._rating = rating
        self._commentCount = commentCount
        self._ID = ID
        self._imageFile = imageFile
        self._descriptionObjectID = descriptionObjectID
    }
    static var temp: Int = 1
    init(sender: AnyObject) {
        if let courseName = sender["name"] as? String, let author = sender["author"] as? String, let collections = sender["collections"] as? Int, let rating = sender["rating"] as? Double, let commentCount = sender["commentCount"] as? Int, let ID = sender["ID"] as? Int, let imageFile = sender["image"] as? AVFile, let descriptionObjectID = sender["descriptionObjectID"] as? String {

            if Introduction.temp == 4 {
                Introduction.temp = 1
            }
            configuration(courseName , author: author, collections: collections, rating: rating, commentCount: commentCount, ID: ID, imageFile: imageFile, descriptionObjectID: descriptionObjectID)
        }
    }
}