//
//  NewPostViewController.swift
//  myInsta
//
//  Created by Hamsika Pongubala on 10/8/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var imageUpload: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Post(_ sender: Any) {
        
//       PostCell.postUserImage(image: imageUpload.image, withCaption: captionField.text) { (bool, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    @IBAction func onUploade(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       
        imageUpload.image = originalImage
    
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

}
