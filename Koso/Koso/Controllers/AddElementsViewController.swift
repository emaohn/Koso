//
//  AddElements.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/25/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class AddElementsViewController: UIViewController {
    var selectedElement: Element?
    
    @IBOutlet weak var addToDoButton: UIButton!
    @IBOutlet weak var addListButton: UIButton!
    @IBOutlet weak var addAgendaButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addToDoButtonPressed(_ sender: UIButton) {
        selectedElement = CoreDataHelper.newToDo()
        self.performSegue(withIdentifier: "backToDisplayProject", sender: self)
    }
    
    @IBAction func addListButtonPressed(_ sender: UIButton) {
        selectedElement = CoreDataHelper.newList()
        self.performSegue(withIdentifier: "backToDisplayProject", sender: self)
    }
    
    @IBAction func addAgendaButtonPressed(_ sender: UIButton) {
        selectedElement = CoreDataHelper.newAgenda()
        self.performSegue(withIdentifier: "backToDisplayProject", sender: self)    }
    
    @IBAction func addNoteButtonPressed(_ sender: UIButton) {
        selectedElement = CoreDataHelper.newNote()
        self.performSegue(withIdentifier: "backToDisplayProject", sender: self)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "backToDisplayProject":
            let destination = segue.destination as? DisplayProjectViewController
            destination?.project?.addToElement(selectedElement!)
            CoreDataHelper.saveProject()
        default:
            print("error")
        }
    }
    
}
