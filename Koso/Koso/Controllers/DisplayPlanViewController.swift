//
//  AgendaBreakDownViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/5/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class DisplayPlanViewController: UIViewController {
    var plan: Plan?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let plan = plan else {return}
        titleTextField.text = plan.title
        locationTextField.text = plan.location
        startTextField.text = plan.startTime
        endTextField.text = plan.endTime
        detailsTextView.text = plan.details
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "save":
            plan?.title = titleTextField.text
            plan?.location = locationTextField.text
            plan?.startTime = startTextField.text
            plan?.endTime = endTextField.text
            plan?.details = detailsTextView.text
        case "cancel":
            print("cancel")
        default:
            print("error")
        }
    }
}

extension DisplayPlanViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayPlanViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
