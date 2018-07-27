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
    
    let projects = [Project]()
    
    @IBOutlet weak var elementsTableView: UITableView!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDo", for: indexPath) as! ToDoTableViewCell
//        let project = projects[indexPath.row]
//        cell.titleLabel.text = project.name
//        cell.dueDateLabel.text = project.dueDate?.convertToString()
//        cell.numDaysLeftLabel.text = String(project.numDaysLeft)
//        cell.projectDescriptionLabel.text = project.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: change this to the count of the array
//        items.count
        return projects.count
    }
    
}
