//
//  Introdution.swift
//  DayLesson
//
//  Created by fzs on 16/2/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import Foundation
import UIKit

class Introduction {
    var briefImage: UIImage!
    private var _courseName: String!
    private var _author: String!
    private var _collections: Int!
    
    
    var courseName: String {
        return _courseName
    }
    var author: String {
        return _author
    }
    var collectioons: Int {
        return _collections
    }
    
    private func configuration(briefImage: UIImage, courseName: String, author: String, collections: Int) {
        self.briefImage = briefImage
        self._courseName = courseName
        self._author = author
        self._collections = collections
    }
    static var temp: Int = 1
    init(sender: AnyObject) {
        if let courseName = sender["name"] as? String, let author = sender["author"] as? String, let collections = sender["collections"] as? Int {
            configuration(UIImage(named: "shili\(Introduction.temp++)")!, courseName: courseName , author: author, collections: collections)
        }
    }
}