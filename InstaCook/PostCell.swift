//
//  PostCell.swift
//  InstaCook
//
//  Created by vagelis spirou on 27/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        
    }
    
    func updateCell(_ post: Post) {
        
        titleLbl.text = post.title
        descLbl.text = post.postDescription
        postImg.image = DataService.instance.imageForPath(post.imagePath)
        
    }
    
}
