//
//  NewProjectViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/24/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class NewProjectViewController: UIViewController {
    
    @IBOutlet weak var nameDateView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var projectDescriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        hideKeyboardWhenTappedAround()
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func setup() {
        descriptionView.layer.shadowOffset = CGSize(width: 0, height: 1)
        descriptionView.layer.shadowOpacity = 0.05
        descriptionView.layer.shadowColor = UIColor.black.cgColor
        descriptionView.layer.shadowRadius = 35
        descriptionView.layer.cornerRadius = 8
        descriptionView.layer.masksToBounds = true
        
        nameDateView.layer.shadowOffset = CGSize(width: 0, height: 1)
        nameDateView.layer.shadowOpacity = 0.05
        nameDateView.layer.shadowColor = UIColor.black.cgColor
        nameDateView.layer.shadowRadius = 35
        nameDateView.layer.cornerRadius = 8
        nameDateView.layer.masksToBounds = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }


    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will show: \(notification.name.rawValue)")

        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            //view.frame.origin.y = -keyboardRect.height + 64
            view.frame.origin.y = -keyboardRect.height  + 128
        } else {
            view.frame.origin.y = 128
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "beginProject":
            print("Creating new project")
            let project = CoreDataHelper.newProject()
            
            project.name = projectNameTextField.text
            if project.projectDescription != "" {
                project.projectDescription = projectDescriptionTextField.text
            } else {
                project.projectDescription = "project description"
            }
            project.dueDate = deadlineDatePicker.date
            
            let destination = segue.destination as? DisplayProjectViewController
            destination?.project = project
            
            CoreDataHelper.saveProject()
        case "cancelNewProject":
            print("new project canceled")
        default:
            print("error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        projectDescriptionTextField.text = ""
    }
}

extension NewProjectViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewProjectViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


