//
//  PlanTableViewCell.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/1/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class PlanTableViewCell: UITableViewCell {
    var delegate: PlanTableViewCellDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func awakeFromNib() {
        titleTextField.delegate = self
        startTimeTextField.delegate = self
        locationTextField.delegate = self
        endTimeTextField.delegate = self
    }
}

protocol PlanTableViewCellDelegate: class {
    func didEndEditing(_ cell: PlanTableViewCell)
}

extension PlanTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(self)
        let text = textField.text
        let index = textField.tag
    }
}

