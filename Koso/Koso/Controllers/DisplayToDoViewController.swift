//
//  DisplayToDoViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/27/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class DisplayToDoViewController: UIViewController {
    var todos = [ToDo]()
    
    @IBOutlet weak var centerPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var addToDoButton: UIBarButtonItem!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addToDoButtonPressed(_ sender: UIBarButtonItem) {
        todos.append(CoreDataHelper.newToDo())
    }
}

extension DisplayToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        centerPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
