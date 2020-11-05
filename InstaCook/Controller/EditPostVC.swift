//
//  EditPostVC.swift
//  InstaCook
//
//  Created by vagelis spirou on 4/11/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

class EditPostVC: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var addPicButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    var theNumberOfRow: Int!
    var post: Post!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        updateButton.layer.cornerRadius = 10
        postImageView.layer.cornerRadius = postImageView.frame.size.width / 2
        
        titleTextField.text = post.title
        descriptionTextField.text = post.postDescription
        postImageView.image = DataService.instance.imageForPath(post.imagePath)
        postImageView.contentMode = .scaleToFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditPostVC.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    deinit {
      
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
     
     }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height + 150
            
        } else {
            
            view.frame.origin.y = 0
            
        }
        
    }
    
    @objc func handleTap() {
        
        view.endEditing(true)
        
    }
    
    @IBAction func pictureBtnPressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateBtnPressed(_ sender: UIButton) {
        
        if let title = titleTextField.text, let description = descriptionTextField.text, let image = postImageView.image {
            
            let imgPath = DataService.instance.saveImageAndCreatePath(image)
            let updatePost = Post(imagePath: imgPath, title: title, description: description)
            DataService.instance.updatePost(forRow: theNumberOfRow, post: updatePost)
                
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension EditPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.originalImage] as? UIImage else { return }
    imagePicker.dismiss(animated: true, completion: nil)
    postImageView.image = selectedImage
}
}
