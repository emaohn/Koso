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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
//    override func awakeFromNib() {
//        titleTextField.delegate = self
//        startTimeTextField.delegate = self
//        locationTextField.delegate = self
//        endTimeTextField.delegate = self
//    }
}

protocol PlanTableViewCellDelegate: class {
    func didEndEditing(_ cell: PlanTableViewCell)
}

extension PlanTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(self)
    }
}

