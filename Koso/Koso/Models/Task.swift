//
//  Task.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/25/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation

class Task {
    var task: String
    var subtasks: [Task]
    
    init(name: String) {
        self.task = name
        subtasks = [Task]()
    }
    
    func addSubtask(task: Task) {
        subtasks.append(task)
    }
}
