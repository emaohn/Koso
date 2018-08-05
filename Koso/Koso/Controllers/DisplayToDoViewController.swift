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
    var selectedToDo: ToDo?
    
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
    
    @IBAction func addToDoButtonPressed(_ sender: UIBarButtonItem) {
        var newToDo = CoreDataHelper.newToDo()
        newToDo.completed = false
        todo?.addToToDo(newToDo)
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
       case "taskBreakDown":
            guard let todo = selectedToDo else {return}
            let destination = segue.destination as? ToDoBreakdownViewController
                destination?.todo = todo
        default:
            print("error")
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        CoreDataHelper.saveProject()
    }
}

extension DisplayToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = todos[indexPath.row]
        if let task = task.title {
            cell1.taskTextField.text = task
        }
        cell1.completionButtonTouched = {(cell) in guard tableView.indexPath(for: cell) != nil
            else { return }
            if !task.completed {
                task.completed = true
                cell1.completionButton.setTitle("[✓]", for: .normal)
            } else {
                task.completed = false
                cell1.completionButton.setTitle("[  ]", for: .normal)
            }
        }
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "taskTableviewCell", sender: self)
    }
}

extension DisplayToDoViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayToDoViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
