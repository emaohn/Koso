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
    var todo: ToDo?
    var todos = [ToDo]()
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var centerPopupConstraint: NSLayoutConstraint!
    @IBOutlet weak var addToDoButton: UIBarButtonItem!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveToDos()
    }
    
    func retrieveToDos() {
        todos = todo?.toDo?.allObjects as! [ToDo]
    }
    
    func displayPopup() {
        centerPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func addToDoButtonPressed(_ sender: UIBarButtonItem) {
        todo?.addToToDo(CoreDataHelper.newToDo())
        retrieveToDos()
        toDoTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch  identifier {
        case "saveToDo":
            for index in 0..<todos.count {
                let cell = toDoTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! TaskTableViewCell
                guard let task = cell.taskTextField.text,
                    let todo = todo?.toDo?.allObjects[index] as? ToDo
                    else {return}
                
                todo.title = task
            }
            CoreDataHelper.saveProject()
        default:
            print("error")
        }
    }
}

extension DisplayToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = todos[indexPath.row]
        if let task = task.title {
            cell.taskTextField.text = task
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayPopup()
    }
}
