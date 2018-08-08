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
        setup()
    }
    
    func setup() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        headerView.layer.cornerRadius = 15
        headerView.layer.masksToBounds = true
        
        detailsView.layer.shadowOffset = CGSize(width: 0, height: 1)
        detailsView.layer.shadowOpacity = 0.05
        detailsView.layer.shadowColor = UIColor.black.cgColor
        detailsView.layer.shadowRadius = 35
        detailsView.layer.cornerRadius = 15
        detailsView.layer.masksToBounds = true
        
        detailsTextView.layer.shadowOffset = CGSize(width: 0, height: 1)
        detailsTextView.layer.shadowOpacity = 0.05
        detailsTextView.layer.shadowColor = UIColor.black.cgColor
        detailsTextView.layer.shadowRadius = 35
        detailsTextView.layer.cornerRadius = 15
        detailsTextView.layer.masksToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let plan = plan else {return}
        titleTextField.text = plan.title
        locationTextField.text = plan.location
        guard let start = plan.startTime, let end = plan.endTime else {return}
        startTextField.text = start
        endTextField.text = end
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
