//
//  DisplayNoteViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/27/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class DisplayNoteViewController: UIViewController {
    var note: Note?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        noteTextView.keyboardDismissMode = .onDrag
        
        noteTextView.layer.shadowOffset = CGSize(width: 0, height: 1)
        noteTextView.layer.shadowOpacity = 0.05
        noteTextView.layer.shadowColor = UIColor.black.cgColor
        noteTextView.layer.shadowRadius = 35
        noteTextView.layer.cornerRadius = 8
        noteTextView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = note?.title
        noteTextView.text = note?.note
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "saveNote":
            note?.note = noteTextView.text
            note?.title = titleTextField.text
            CoreDataHelper.saveProject()
        case "cancel":
            print("Canceling")
        default:
            print("error")
        }
    }
}

extension DisplayNoteViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayToDoViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
