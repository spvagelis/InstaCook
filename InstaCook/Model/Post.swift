//
//  Post.swift
//  InstaCook
//
//  Created by vagelis spirou on 26/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation


class Post: NSObject, NSCoding {
    
    
    
    fileprivate var _imagePath: String!
    fileprivate var _title: String!
    fileprivate var _postDescription: String!
    
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDescription: String {
        return _postDescription
    }
    
    init(imagePath: String, title: String, description: String) {
        
        self._imagePath = imagePath
        self._title = title
        self._postDescription = description
        
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self._imagePath, forKey: "imagePath")
        coder.encode(self._postDescription, forKey: "description")
        coder.encode(self._title, forKey: "title")
        
    }
    
    required init?(coder: NSCoder) {
        
        self._imagePath = coder.decodeObject(forKey: "imagePath") as? String ?? ""
        self._postDescription = coder.decodeObject(forKey: "description") as? String ?? ""
        self._title = coder.decodeObject(forKey: "title") as? String ?? ""
        
    }
}
