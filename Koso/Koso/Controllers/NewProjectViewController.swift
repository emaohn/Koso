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
        hideKeyboardWhenTappedAround()
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


