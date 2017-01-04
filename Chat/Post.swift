//
//  Post.swift
//  Chat
//
//  Created by MacBookPro on 2017. 1. 3..
//  Copyright © 2017년 EDCAN. All rights reserved.
//

struct Post{
    var content : String
    var image : String
    var tags : [String]
    var userID : String
    
    init?(dict : [String : Any]){
        guard
            let content = dict["content"] as? String,
            let image = dict["image"] as? String,
            let tags = dict["tags"] as? [String],
            let userID = dict["userID"] as? String
        else{ return nil }
        
        self.content = content
        self.image = image
        self.tags = tags
        self.userID = userID
    }
    
    init(content : String, image : String, tags : [String], userID : String){
        self.content = content
        self.image = image
        self.tags = tags
        self.userID = userID
    }
    
    func toDictionary() -> [String : Any]{
        return [
            "content" : self.content,
            "image" : self.image,
            "tags" : self.tags,
            "userID" : self.userID
        ]
    }
    
    func toJSON() -> String{
        return "{'content' : \(self.content), 'image' : \(self.image), 'tags' : \(self.tags),'userID' : \(self.userID) }"
    }
}
