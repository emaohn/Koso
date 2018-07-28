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
    @IBOutlet weak var addToDoButton: UIButton!
    @IBOutlet weak var addListButton: UIButton!
    @IBOutlet weak var addAgendaButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addToDoButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addedToDo", sender: self)
    }
    @IBAction func addListButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addedList", sender: self)
    }
    @IBAction func addAgendaButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addedAgenda", sender: self)
    }
    @IBAction func addNoteButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addedNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "addedToDo":
            let todo = ToDo()
            let destination =  segue.destination as? DisplayProjectViewController
            destination?.project?.addToElement(todo)
        case "addedList":
            let list = List()
            let destination =  segue.destination as? DisplayProjectViewController
            destination?.project?.addToElement(list)
        case "addedAgenda":
            let agenda = Agenda()
            let destination =  segue.destination as? DisplayProjectViewController
            destination?.project?.addToElement(agenda)
        case "addedNote":
            let note = Note()
            let destination =  segue.destination as? DisplayProjectViewController
            destination?.project?.addToElement(note)
        default:
            print("error")
        }
    }
    
}
