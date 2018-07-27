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
        let note = NSEntityDescription.insertNewObject(forEntityName: "Project", into: context) as! Project
        return note
    }
    
    static func saveProject() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: Project) {
        context.delete(note)
        saveProject()
    }
    
    static func retrieveProjects() -> [Project]{
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



