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
    
    var elements: [Element]?
    
    @IBOutlet weak var elementsTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var numDaysLeftLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "addItem":
            print("adding new item")
        case "save":
            CoreDataHelper.saveProject()
        case "back":
            print("boing back to main page")
        default:
            print("error")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {

    }
}

extension DisplayProjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements?[indexPath.row]
        if let element = element as? ToDo {
            let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoTableViewCell
            return cell
        } else if let element = element as? List {
            let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! ListTableViewCell
            return cell
        } else if let element = element as? Agenda {
            let cell = tableView.dequeueReusableCell(withIdentifier: "agenda", for: indexPath) as! AgendaTableViewCell
            return cell
        } else if let element = element as? Note {
            let cell = tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath) as! NoteTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (elements?.count)!
    }
    
}
