//
//  ProjectManagerViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/24/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class ProjectManagerViewController: UIViewController {
    var projects = [Project]() {
        didSet {
            projectTableView.reloadData()
        }
    }
    
    @IBOutlet weak var projectTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projects = CoreDataHelper.retrieveProjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "newProject":
            print("creating new project")
            
        case "openProject":
            print("opening project")
            guard let indexPath = projectTableView.indexPathForSelectedRow else {return}
            let project = projects[indexPath.row]
            let destination = segue.destination as? DisplayProjectViewController
            destination?.project = project
            
        default:
            print("Error")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        projects = CoreDataHelper.retrieveProjects()
    }
}
extension ProjectManagerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "existingProject", for: indexPath) as! ProjectTableviewCell
        let project = projects[indexPath.row]
        cell.titleLabel.text = project.name
        cell.dueDateLabel.text = project.dueDate?.convertToString()
        cell.numDaysLeftLabel.text = String(project.numDaysLeft)
        cell.projectDescriptionLabel.text = project.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openProject", sender: self)
    }
}
