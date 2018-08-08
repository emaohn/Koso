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
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var isTop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setup()
        
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.navigationBarTap))
        hideKeyboard.numberOfTapsRequired = 1
        navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func navigationBarTap(_ recognizer: UIGestureRecognizer) {
        view.endEditing(true)
        // OR  USE  yourSearchBarName.endEditing(true)
        
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
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @IBAction func titleBegin(_ sender: Any) {
        isTop = true
    }
    @IBAction func titleEnd(_ sender: Any) {
        isTop = false
    }
    @IBAction func locationBegin(_ sender: Any) {
        isTop = true
    }
    @IBAction func locationEnd(_ sender: Any) {
        isTop = false
    }
    @IBAction func startBegin(_ sender: Any) {
        isTop = true
    }
    @IBAction func startEnd(_ sender: Any) {
        isTop = false
    }
    @IBAction func endBegin(_ sender: Any) {
        isTop = true
    }
    @IBAction func endEnd(_ sender: Any) {
        isTop = false
    }
    

    
    @objc func keyboardWillChange(notification: Notification) {
        if isTop != true{
            print("Keyboard will show: \(notification.name.rawValue)")
            
            
            
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            
            if notification.name == Notification.Name.UIKeyboardWillShow ||
                notification.name == Notification.Name.UIKeyboardWillChangeFrame {
                //view.frame.origin.y = -keyboardRect.height + 64
                view.frame.origin.y = -keyboardRect.height  + 128
            } else {
                view.frame.origin.y = 115
            }
        }
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
