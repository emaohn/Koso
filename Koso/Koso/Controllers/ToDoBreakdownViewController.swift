//
//  ToDoBreakdownViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 8/3/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class ToDoBreakdownViewController: UIViewController {
    var todo: ToDo?
    var todos = [ToDo]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTitleTextField.text = todo?.title
        retrieveToDos()
    }
    
    func retrieveToDos() {
//        todos = todo?.toDo?.allObjects as! [ToDo]
//        tableView.reloadData()
        guard let myTodos = self.todo?.toDo?.allObjects as? [ToDo] else {return}
        if (myTodos.count) > 1{
            todos = myTodos.sorted(by: { (task1, task2) -> Bool in
                return task1.timeStamp! < task2.timeStamp!
            })
        }
        else{
            todos = myTodos
        }
        tableView.reloadData()
    }
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "What do you need to do?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = UIColor(red: 201/255, green: 200/255, blue: 209/255, alpha: 1)
        //title
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "ex. wash dishes"
        }
        
        // Create the actions
        let okAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let todoTextField = alertController.textFields![0] as UITextField?
            
            let todo = CoreDataHelper.newToDo()
            todo.title = todoTextField?.text
            todo.completed = false
            
            self.todo?.addToToDo(todo)
            self.retrieveToDos()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "save":
            todo?.title = taskTitleTextField.text
            CoreDataHelper.saveProject()
        default:
            print("error")
        }
    }
}

extension ToDoBreakdownViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = todos[indexPath.row]
        cell.taskLabel.text = task.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedTask = todos[indexPath.row]
            CoreDataHelper.delete(todo: deletedTask)
            todos = todo?.toDo?.allObjects as! [ToDo]
        }
    }
}

extension ToDoBreakdownViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ToDoBreakdownViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
