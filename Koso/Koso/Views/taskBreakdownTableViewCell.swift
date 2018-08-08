//
//  taskBreakdownTableViewCell.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/7/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class taskBreakdownTableViewCell: UITableViewCell {
    var completionButtonTouched: ((UITableViewCell) -> Void)? = nil
    
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!

    @IBAction func completionButtonPressed(_ sender: UIButton) {
        completionButton.isSelected = !completionButton.isSelected
        
        completionButtonTouched?(self)
    }
}
