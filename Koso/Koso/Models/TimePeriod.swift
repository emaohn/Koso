//
//  TimePeriod.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/25/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation

class TimePeriod {
    var length: Time
    
    
    init(lengthOf time: Time){
        self.length = time
    }
}

enum Time {
    case day, week, month
}
