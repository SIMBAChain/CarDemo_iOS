//
//  PostRegistrationViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/18/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit

class PostRegistrationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet var Image:UIImageView!
    
    
    let imagePickerController = UIImagePickerController()
    

    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
    @IBAction func AddImage()
    {
    let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
    
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.allowsEditing = false
                self.imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.imagePickerController.cameraCaptureMode = .photo
                self.imagePickerController.modalPresentationStyle = .fullScreen
                self.present(self.imagePickerController,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
            }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            // UIImagePickerController is a view controller that lets a user pick media from their photo library.
            
            
            // Only allow photos to be picked, not taken.
            self.imagePickerController.sourceType = .photoLibrary
            
            // Make sure ViewController is notified when the user picks an image.
            self.imagePickerController.delegate = self
            self.present(self.imagePickerController, animated: true, completion: nil)
            }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        Image.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
