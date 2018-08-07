//
//  ProjectViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/24/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class DisplayProjectViewController: UIViewController {
    var project: Project?
    var element: Element?
    
    var elements = [Element]() {
        didSet {
            elementsTableView.reloadData()
        }
    }
    
    @IBOutlet weak var elementsTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var numDaysLeftLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = project?.name
        deadlineLabel.text = project?.dueDate?.convertToString()
       // numDaysLeftLabel.text = "\(String(describing: project?.numDaysLeft))"
        projectDescriptionLabel.text = project?.projectDescription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = project?.name
        reloadElements()
    }
    
    func reloadElements() {
        guard let myElements = project?.element?.allObjects as? [Element] else {return}
        if(myElements.count) > 1 {
            elements = myElements.sorted(by: { (element1, element2) -> Bool in
                return element1.timeStamp! < element2.timeStamp!
            })
        } else {
            elements = myElements
        }
        elementsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "addItem":
            let destination = segue.destination as? AddElementsViewController
            destination?.project = self.project
        case "save":
            project?.name = titleLabel.text
            CoreDataHelper.saveProject()
        case "back":
            print("boing back to main page")
        case "openAgenda":
            let destination = segue.destination as? DisplayAgendaViewController
            destination?.agenda = element as? Agenda
        case "openNote":
            let destination = segue.destination as? DisplayNoteViewController
            destination?.note = element as? Note
        case "openToDo":
            let destination = segue.destination as? DisplayToDoViewController
            destination?.todo = element as? ToDo
        default:
            print("error")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        reloadElements()
        CoreDataHelper.saveProject()
    }
}

extension DisplayProjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        if let todo = element as? ToDo {
            let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoTableViewCell
            if let title = todo.title {
                cell.titleLabel.text = title
            }
            if let deadline = todo.deadline {
                cell.dueDateLabel.text = "Completed by: " + deadline.convertToString()
            }
            return cell
        } else if let agenda = element as? Agenda {
            let cell = tableView.dequeueReusableCell(withIdentifier: "agenda", for: indexPath) as! AgendaTableViewCell
            cell.timeIntervalLabel.text = agenda.timeInterval
            cell.startDateLabel.text = agenda.start
            cell.endDateLabel.text = agenda.end
            var planLabel: String = "Plans: "
            for plan in (agenda.plan?.allObjects as? [Plan])! {
                planLabel += " \(String(describing: plan.title))"
            }
            cell.plansLabel.text = planLabel
            return cell
        } else if let note = element as? Note {
            let cell = tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath) as! NoteTableViewCell
            cell.titleLabel.text = note.title
            cell.noteTextField.text = note.note
    
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (elements.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        element = elements[indexPath.row]
        if let _ = element as? ToDo {
            self.performSegue(withIdentifier: "openToDo", sender: self)
        } else if let _ = element as? Agenda {
            self.performSegue(withIdentifier: "openAgenda", sender: self)
        } else if let _ = element as? Note {
            self.performSegue(withIdentifier: "openNote", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedElement = elements[indexPath.row]
            CoreDataHelper.delete(element: deletedElement)
            elements = project?.element?.allObjects as! [Element]
        }
    }
}

extension DisplayProjectViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayProjectViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
