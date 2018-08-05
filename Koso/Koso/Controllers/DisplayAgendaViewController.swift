//
//  DisplayAgendaViewController.swift
//  Koso
//
//  Created by Emmie Ohnuki on 7/27/18.
//  Copyright © 2018 Emmie Ohnuki. All rights reserved.
//

import Foundation
import UIKit

class DisplayAgendaViewController: UIViewController {
    var agenda: Agenda?
    var plans = [Plan]() {
        didSet {
            planTableView.reloadData()
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var timePeriodTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    @IBOutlet weak var planTableView: UITableView!
    
    @IBOutlet weak var addPlanButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //planTableView.keyboardDismissMode = .interactive
        planTableView.keyboardDismissMode = .onDrag
        reloadPlans()
        setup()
    }
    
    func setup() {
        startTimeTextField.text = agenda?.start
        timePeriodTextField.text = agenda?.timeInterval
        endTimeTextField.text = agenda?.end
    }
    
    func createNewPlan(){
        let plan = CoreDataHelper.newPlan()
        plan.title = ""
        plan.details = ""
        plan.endTime = ""
        plan.startTime = ""
        plan.timeStamp = Date()
        plan.location = ""
        agenda?.addToPlan(plan)
        
    }
    @IBAction func addPlanButtonPressed(_ sender: UIBarButtonItem) {
        createNewPlan()
        save()
        reloadPlans()
    }
    
    func reloadPlans() {
        plans = (agenda?.plan?.allObjects as? [Plan])!
//        if myPlans.count > 1{
//            plans = myPlans.sorted(by: { (plan1, plan2) -> Bool in
//                return plan1.timeStamp! > plan2.timeStamp!
//            })
//        }
//        else{
//            plans = myPlans
//        }
    }
    
    func save() {
        for index in 0..<plans.count {
            let cell = planTableView.cellForRow(at: IndexPath(row: index, section: 0)) as! PlanTableViewCell
            
            guard let title = cell.titleTextField.text,
                let start = cell.startTimeTextField.text,
                let end = cell.endTimeTextField.text,
                let details = cell.detailsTextView.text,
                let location = cell.locationTextField.text
                
                else {return}
            plans[index].title = title
            plans[index].startTime = start
            plans[index].endTime = end
            plans[index].details = details
            plans[index].location = location
            plans[index].timeStamp = Date()
        }
        if plans.count != 0{
            agenda?.timeInterval = timePeriodTextField.text
            agenda?.start = startTimeTextField.text
            agenda?.end = startTimeTextField.text
            CoreDataHelper.saveProject()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "save":
            save()
        default:
            print("error")
        }
    }
}
extension DisplayAgendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (plans.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell", for: indexPath) as! PlanTableViewCell
        let plan = plans[indexPath.row]
        cell.titleTextField.text = plan.title
        cell.titleTextField.tag = indexPath.row
        cell.detailsTextView.text = plan.details
        cell.detailsTextView.tag = indexPath.row
        cell.startTimeTextField.text = plan.startTime
        cell.startTimeTextField.tag = indexPath.row
        cell.endTimeTextField.text = plan.endTime
        cell.endTimeTextField.tag = indexPath.row
        cell.locationTextField.text = plan.location
        cell.locationTextField.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell", for: indexPath) as! PlanTableViewCell
        let plan = plans[indexPath.row]
        plan.title = cell.titleTextField.text
        plan.details = cell.detailsTextView.text
        plan.startTime = cell.startTimeTextField.text
        plan.endTime = cell.endTimeTextField.text
        plan.location = cell.locationTextField.text
    }
}

extension DisplayAgendaViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DisplayAgendaViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DisplayAgendaViewController: PlanTableViewCellDelegate {
    func didEndEditing(_ cell: PlanTableViewCell) {
        let index = cell.endTimeTextField.tag
        
        print("saving data")
    }
    
}
