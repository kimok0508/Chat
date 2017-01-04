//
//  NewPostViewController.swift
//  Chat
//
//  Created by MacBookPro on 2017. 1. 3..
//  Copyright © 2017년 EDCAN. All rights reserved.
//

import UIKit
import VisualEffectView
import Firebase

extension UITextView{
    func extractTags() -> [String]{
        guard let texts = self.text else { return [] }
        var tags : [String] = []
        let words = texts.components(separatedBy: " ")
        
        for word in words{
            if word.hasPrefix("#"){
                var tag = word as String
                tag = String(tag.characters.dropFirst())
                tags.append(tag)
            }
        }
        
        return tags
    }
}

class NewPostViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    let defaultPadding : CGFloat = 16
    let imageSelectButton = UIButton(type : .system)
    let imageCaptureButton = UIButton(type : .system)
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let normalEffect = UIBlurEffect(style : .regular)
    let highlightEffect = UIBlurEffect(style : .dark)
    let selectButtonEffectView = VisualEffectView()
    let captureButtonEffectView = VisualEffectView()
    let contentTextView = UITextView()
    let contentEffectView = VisualEffectView()
    let postBarButtonItem = UIBarButtonItem(
        title: "작성",
        style: .plain,
        target: nil,
        action: #selector(postButtonDidSelect)
    )
    let cancelBarButtonItem = UIBarButtonItem(
        title : "취소",
        style : .plain,
        target : nil,
        action : #selector(cancelButtonDidSelect)
    )
    
    var imageData = Data()
    var imageName : String? = nil
//    var currentUser = FIRAuth.auth()!.currentUser
//    let storage = FIRStorage.storage()
//    let storageRef = storage.referenceForURL("gs://chat-250ae.appspot.com")
//    let database = FIRDatabase.database()
//    let databaseRef = database.reference()
    
    func postButtonDidSelect(){
//        let email : String = "test@test.com"
//        guard
//            let contentText = self.contentTextView.text,
//            let currentUser = self.currentUser
//        else{ return }
//        let tags = self.contentTextView.extractTags()
//        var image : String = ""
//        
//        if let imageName = self.imageName{
//            let imagePath = "\(currentUser.uid)/\(imageName)"
//            let metaData = FIRStorageMetadata()
//            metaData.contentType = "image/jpg"
//            
//            self.storageRef.child(imagePath).putData(imageData, metaData){ (meta, error) in
//                if let error = error{
//                    let alertController = UIAlertController(
//                        title: "이미지 업로드 에러",
//                        message: error.localizedDescription,
//                        preferredStyle:.alert
//                    )
//                    
//                    let confirmButton = UIAlertAction(
//                        title: "승인",
//                        style: .done,
//                        handler: nil
//                    )
//                    
//                    alertController.addAction(confirmButton)
//                    present(alertController, animated : true, completion : nil)
//                    return
//                    
//                }else{
//                    let downloadUrl = meta!.downloadURL()!.absoluteString
//                    image = donwloadUrl
//                }
//            }
//        }
//    
//        let post = Post(content : contentText, image : image, tags : tags, userID : currentUser.uid).toDictionary()
//        let postKey = databaseRef.child("post").childByAutoId().key
        
        
    }
    
    func cancelButtonDidSelect(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "새 포스트 작성"
        self.view.backgroundColor = .white
        
        selectButtonEffectView.effect = normalEffect
        captureButtonEffectView.effect = normalEffect
        contentEffectView.effect = normalEffect
        
        self.postBarButtonItem.target = self
        self.navigationItem.rightBarButtonItem = postBarButtonItem
        self.cancelBarButtonItem.target = self
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        imageView.frame = CGRect(
            x : 0,
            y : 0,
            width : self.view.frame.width,
            height : self.view.frame.height
        )
        imageSelectButton.frame = CGRect(
            x : defaultPadding,
            y : 22 + 44 + defaultPadding,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 32
        )
        imageCaptureButton.frame = CGRect(
            x : defaultPadding,
            y : 22 + 44 + defaultPadding + 32,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 32
        )
        contentTextView.frame = CGRect(
            x : defaultPadding,
            y : self.view.frame.height / 2 - 32,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 128
        )
        
        selectButtonEffectView.frame = imageSelectButton.frame
        captureButtonEffectView.frame = captureButtonEffectView.frame
        contentEffectView.frame = contentTextView.frame
        
        imageSelectButton.setTitle("이미지 가져오기", for: .normal)
        imageSelectButton.addTarget(
            self,
            action: #selector(imageSelectButtonDidSelect),
            for: .touchUpInside
        )
        imageSelectButton.layer.cornerRadius = 16
        imageSelectButton.layer.masksToBounds = true
    
        imageCaptureButton.setTitle("카메라 촬영", for: .normal)
        imageCaptureButton.addTarget(
            self,
            action: #selector(imageCaptureButtonDidSelect),
            for: .touchUpInside
        )
        imageCaptureButton.layer.cornerRadius = 16
        imageCaptureButton.layer.masksToBounds = true
        
        contentTextView.backgroundColor = nil
        contentTextView.textAlignment = .center
        contentTextView.font = UIFont.systemFont(ofSize: 18)
        contentTextView.textColor = .white
        contentTextView.text = "내용을 입력하세요"
        contentTextView.layer.cornerRadius = 16
        contentTextView.layer.masksToBounds = true
        contentTextView.delegate = self
        let size = self.size(for: self.contentTextView.text, width: 0, font: UIFont.systemFont(ofSize: 16))
        contentTextView.frame = CGRect(
            x : self.view.frame.width / 2 - size.width / 2 - 8,
            y : self.view.frame.height / 2 - size.height / 2 - 8,
            width : size.width + 16,
            height : size.height + 16
        )

        
        self.view.addSubview(imageView)
        self.view.addSubview(selectButtonEffectView)
        self.view.addSubview(imageSelectButton)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.view.addSubview(captureButtonEffectView)
            self.view.addSubview(imageCaptureButton)
        }
        
        self.view.addSubview(contentEffectView)
        self.view.addSubview(contentTextView)
    }
    
    func imageCaptureButtonDidSelect(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imageSelectButtonDidSelect(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func size(for string : String, width : CGFloat, font : UIFont) -> CGSize {
        let rect = string.boundingRect(
            with: CGSize(width : width, height : 0),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [NSFontAttributeName : font],
            context: nil
        )
        
        return rect.size
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        dismiss(animated: true, completion: nil)
        
        imageData = UIImageJPEGRepresentation(image, 1.0)!
        let imageUrl = info[UIImagePickerControllerReferenceURL] as! URL
        self.imageName = imageUrl.lastPathComponent
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let size = self.size(for: textView.text, width: 0, font: UIFont.systemFont(ofSize: 16))
        textView.frame = CGRect(
            x : self.view.frame.width / 2 - size.width / 2 - 8,
            y : self.view.frame.height / 2 - size.height / 2 - 8,
            width : size.width + 16,
            height : size.height + 16
        )
    }
}
