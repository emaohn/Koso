//
//  ToDo.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/25/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation

class ToDo: Element {
    var tasks: [Task]
    
    override init() {
        tasks = [Task]()
        super.init()
    }
}
