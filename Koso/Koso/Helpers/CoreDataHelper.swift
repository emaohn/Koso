//
//  CoreDataHelper.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/24/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistanceContainer = appDelegate.persistentContainer
        let context = persistanceContainer.viewContext
        
        return context
    }()
    
    static func newProject() -> Project {
        let project = NSEntityDescription.insertNewObject(forEntityName: "Project", into: context) as! Project
        return project
    }
    
    static func newAgenda() -> Agenda {
        let agenda = NSEntityDescription.insertNewObject(forEntityName: "Agenda", into: context) as! Agenda
        return agenda
    }
    
    static func newImage() -> Image {
        let image = NSEntityDescription.insertNewObject(forEntityName: "Image", into: context) as! Image
        return image
    }
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    static func newPlan() -> Plan {
        let plan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: context) as! Plan
        return plan
    }
    
    static func newToDo() -> ToDo {
        let todo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context) as! ToDo
        return todo
    }
    
    
    static func saveProject() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(project: Project) {
        context.delete(project)
        saveProject()
    }
    
    static func delete(element: Element) {
        context.delete(element)
        saveProject()
    }
    
    static func retrieveProjects() -> [Project] {
        do {
            let fetchRequest = NSFetchRequest<Project>(entityName: "Project")
            let results = try context.fetch(fetchRequest)
            return results.reversed()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
            return []
        }
    }
}



