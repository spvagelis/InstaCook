//
//  DataService.swift
//  InstaCook
//
//  Created by vagelis spirou on 29/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        
        return _loadedPosts
        
    }
    
    func savePosts() {
        
        if let postsData = try? NSKeyedArchiver.archivedData(withRootObject: _loadedPosts, requiringSecureCoding: false) {
            UserDefaults.standard.set(postsData, forKey: "posts")
        } else {
            print("I can't save the post")
        }
    }
    
    func loadPosts() {
        
        if let postsData = UserDefaults.standard.object(forKey: "posts") as? Data {
            
            do {
                
                let postsArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(postsData) as! [Post]

                _loadedPosts = postsArray
                
            } catch {
                debugPrint(error.localizedDescription)
            }
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "postsLoaded"), object: nil))

        }
    }
    
    func saveImageAndCreatePath(_ image: UIImage) -> String {
        
        let imgData = image.pngData()
        let imgPath = "image\(Date.timeIntervalSinceReferenceDate).png"
        
        let fullPath = documentsPathForFileName(imgPath)
        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
        
        return imgPath
        
    }
    
    func imageForPath(_ path: String) -> UIImage? {
        
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        
        return image
        
    }
    
    func addPost(post: Post) {
        
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
        
    }
    
    func documentsPathForFileName(_ name: String) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        
        return fullPath.appendingPathComponent(name)
        
    }
    
}
