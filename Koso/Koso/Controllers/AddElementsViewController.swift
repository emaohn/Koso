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
    var project: Project?
    var selectedElement: Element?
    
    @IBOutlet weak var addToDoButton: UIButton!
    @IBOutlet weak var addAgendaButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.navigationBarTap))
        hideKeyboard.numberOfTapsRequired = 1
        navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func navigationBarTap(_ recognizer: UIGestureRecognizer) {
        view.endEditing(true)
        // OR  USE  yourSearchBarName.endEditing(true)
        
    }
    
    func setupViews() {
        addToDoButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addToDoButton.layer.shadowOpacity = 0.05
        addToDoButton.layer.shadowColor = UIColor.black.cgColor
        addToDoButton.layer.shadowRadius = 35
        addToDoButton.layer.cornerRadius = 25
        addToDoButton.layer.masksToBounds = true
        
        addAgendaButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addAgendaButton.layer.shadowOpacity = 0.05
        addAgendaButton.layer.shadowColor = UIColor.black.cgColor
        addAgendaButton.layer.shadowRadius = 35
        addAgendaButton.layer.cornerRadius = 25
        addAgendaButton.layer.masksToBounds = true
        
        addNoteButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addNoteButton.layer.shadowOpacity = 0.05
        addNoteButton.layer.shadowColor = UIColor.black.cgColor
        addNoteButton.layer.shadowRadius = 35
        addNoteButton.layer.cornerRadius = 25
        addNoteButton.layer.masksToBounds = true
        
    }
    
    @IBAction func addToDoButtonPressed(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "createToDo", sender: self)
        print("add todo")
    }

    @IBAction func addAgendaButtonPressed(_ sender: UIButton) {
        //self.performSegue(withIdentifier: "createAgenda", sender: self)
        print("add agenda")
    }


    @IBAction func addNoteButtonPressed(_ sender: UIButton) {
        print("add note")
        //self.performSegue(withIdentifier: "createNote", sender: self)
    }
    
    @IBAction func cancelNewElementButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "cancel", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "backToDisplayProject":
//            let destination = segue.destination as? DisplayProjectViewController
//            if let element = selectedElement {
//                element.timeStamp = Date()
//                destination?.project?.addToElement(element)
//                CoreDataHelper.saveProject()
//            } else { return }
            print("going back")
        case "createToDo":
            let destination = segue.destination as? DisplayToDoViewController
            let todo = CoreDataHelper.newToDo()
            todo.timeStamp = Date()
            destination?.todo = todo
            project?.addToElement(todo)
        case "createNote":
            let destination = segue.destination as? DisplayNoteViewController
            let note = CoreDataHelper.newNote()
            note.timeStamp = Date()
            destination?.note = note
            project?.addToElement(note)
        case "createAgenda":
            let destination = segue.destination as? DisplayAgendaViewController
            let agenda = CoreDataHelper.newAgenda()
            agenda.timeStamp = Date()
            destination?.agenda = agenda
            project?.addToElement(agenda)
        case "cancel":
            print("canceling")
        default:
            print("error")
        }
    }
    
}
