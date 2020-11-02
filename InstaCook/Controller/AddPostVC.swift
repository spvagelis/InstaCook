//
//  AddPostVC.swift
//  InstaCook
//
//  Created by vagelis spirou on 27/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var makePostBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        makePostBtn.layer.cornerRadius = 10
        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPostVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func addPictureBtnPressed(_ sender: UIButton) {
        
        sender.isHidden = true
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func makePostBtnPressed(_ sender: UIButton) {
        
        if let title = titleTextField.text, let description = descriptionTextField.text, let img = postImage.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imgPath, title: title, description: description)
            DataService.instance.addPost(post: post)
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension AddPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        imagePicker.dismiss(animated: true, completion: nil)
        postImage.image = selectedImage
    }
    
}
