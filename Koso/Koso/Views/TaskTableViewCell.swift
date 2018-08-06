//
//  taskTableViewCell.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/2/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {
    var completionButtonTouched: ((UITableViewCell) -> Void)? = nil
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    @IBAction func completionButtonPressed(_ sender: Any) {
        completionButton.isSelected = !completionButton.isSelected
        completionButtonTouched?(self)
    }
}
