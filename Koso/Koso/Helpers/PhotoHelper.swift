//
//  photoHelper.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/3/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation

import UIKit

class PhotoHelper: NSObject {
    
    var completionHandler: ((UIImage) -> Void)?
    
    func presentActionSheet(from viewController: UIViewController) {
        //initiallizing a new UIAlertController of type actionSheet (pop up at bottom of screen)
        let alertController = UIAlertController(title: nil, message: "Where do you want to get your picture from?", preferredStyle: .actionSheet)
        //checks to see if Camera is available
        //if yes, create new alert action
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let capturePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { action in
                self.presentImagePicker(with: .camera, from: viewController)
            })
            alertController.addAction(capturePhotoAction)
        }
        //same thing w/ photo library
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let uploadAction = UIAlertAction(title: "Upload from Library", style: .default, handler: {action in
                self.presentImagePicker(with: .photoLibrary, from: viewController)
            })
            alertController.addAction(uploadAction)
        }
        //adds cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //passing reference from view controller to alert controller
        viewController.present(alertController, animated: true)
    }
    func presentImagePicker(with sourceType: UIImagePickerControllerSourceType, from viewController: UIViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        
        viewController.present(imagePickerController, animated: true)
    }
}

extension PhotoHelper: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            completionHandler?(selectedImage)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
