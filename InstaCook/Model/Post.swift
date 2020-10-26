//
//  Post.swift
//  InstaCook
//
//  Created by vagelis spirou on 26/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation


class Post {
    
    fileprivate var imagePath: String
    fileprivate var title: String
    fileprivate var postDescription: String
    
    init(imagePath: String, title: String, description: String) {
        
        self.imagePath = imagePath
        self.title = title
        self.postDescription = description
        
    }
    
}
