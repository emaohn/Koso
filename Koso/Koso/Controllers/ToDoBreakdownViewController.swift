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
    
    func retrieveToDos() {
        todos = todo?.toDo?.allObjects as! [ToDo]
    }
    @IBAction func addTaskButtonPressed(_ sender: Any) {
        todo?.addToToDo(CoreDataHelper.newToDo())
        retrieveToDos()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveToDos()
    }
}

extension ToDoBreakdownViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = todos[indexPath.row]
        cell.taskTextField.text = task.title
        return cell
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
