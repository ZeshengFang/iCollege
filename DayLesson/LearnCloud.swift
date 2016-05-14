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
    
    func getCourseDetailWithID(ID: String) -> CourseDetail {
        let obeject = AVQuery.getObjectOfClass("CourseDetail", objectId: ID)
        let courseDetail = CourseDetail(object: obeject)
        return courseDetail
    }
    
    func getCommentWithID(ID: String) -> Comment {
        let obeject = AVQuery.getObjectOfClass("Comment", objectId: ID)
        let comment = Comment(object: obeject)
        return comment
    }
    func getIntroductionWithID(ID: String) -> [Introduction] {
        let query = AVQuery(className: "Test")
        var introductions = [Introduction]()
        for object in query.findObjects() {
            introductions.append(Introduction(sender: object))
        }
        return introductions
    }
    
    func getArticles() -> [Article]{
        let query = AVQuery(className: "article")
        var articles = [Article]()
        for object in query.findObjects() {
            articles.append(Article(object: object as! AVObject))
        }
        return articles
    }
    func getUserWithID(ID: String) -> AVUser {
        let user = AVQuery.getUserObjectWithId(ID)
        return user
    }
    func getArticleWithID(ID: String) -> AVObject {
        let query = AVQuery(className: "article")
        return query.getObjectWithId(ID)
        //return AVQuery.getObjectOfClass("article", objectId: ID)
    }
    func getAllComment() -> [Comment] {
        let query = AVQuery(className: "Comment")
        var comments: [Comment] = []
        for object in query.findObjects() {
            comments.append(Comment(object: object as! AVObject))
        }
        return comments
    }

}
