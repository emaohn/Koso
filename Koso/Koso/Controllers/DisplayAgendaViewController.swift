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
    var plans: [Plan]?
    
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
        reloadPlans()
    }
    
    func setup() {
        startTimeTextField.text = agenda?.start
        timePeriodTextField.text = agenda?.timeInterval
        endTimeTextField.text = agenda?.end
    }
    
    @IBAction func addPlanButtonPressed(_ sender: UIBarButtonItem) {
        agenda?.addToPlan(CoreDataHelper.newPlan())
        reloadPlans()
        planTableView.reloadData()
    }
    
    func reloadPlans() {
         plans = agenda?.plan?.allObjects as? [Plan]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "save":
            guard let plans = plans  else {return}
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
            }
            
            agenda?.timeInterval = timePeriodTextField.text
            agenda?.start = startTimeTextField.text
            agenda?.end = startTimeTextField.text
            
            CoreDataHelper.saveProject()
        default:
            print("error")
        }
    }
}
extension DisplayAgendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (plans?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell", for: indexPath) as! PlanTableViewCell
        let plan = plans![indexPath.row]
        cell.titleTextField.text = plan.title
        cell.detailsTextView.text = plan.details
        cell.startTimeTextField.text = plan.startTime
        cell.endTimeTextField.text = plan.endTime
        cell.locationTextField.text = plan.location
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell", for: indexPath) as! PlanTableViewCell
        let plan = plans?[indexPath.row]
        plan?.title = cell.titleTextField.text
        plan?.details = cell.detailsTextView.text
        plan?.startTime = cell.startTimeTextField.text
        plan?.endTime = cell.endTimeTextField.text
        plan?.location = cell.locationTextField.text
    }
}
