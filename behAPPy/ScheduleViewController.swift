//
//  ScheduleViewController.swift
//  behAPPy
//
//  Created by block7 on 3/29/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class ScheduleViewController: UITableViewController, NewScheduleViewControllerDelegate {
    
    var assignments: [Assignment]
    
    required init?(coder aDecoder: NSCoder) {
        assignments = [Assignment]()
        
        let row1 = Assignment(title: "hello")
        let row2 = Assignment(title: "cat")
        let row3 = Assignment(title: "dog")
        assignments.append(row1)
        assignments.append(row2)
        assignments.append(row3)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("assignmentItemCell", forIndexPath: indexPath)
        let assignment = assignments[indexPath.row]
        textForRow(cell, withAssignment: assignment)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath) {
        
        assignments.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func textForRow(cell: UITableViewCell, withAssignment assignment: Assignment) {
        let label = cell.viewWithTag(734) as! UILabel
        label.text = assignment.title
    }
    
    
    func didCancel(controller: NewScheduleViewController) {
        print("did cancel")
    }
    
    func newAssignment(controller: NewScheduleViewController, didFinishAddingAssignment assignment: Assignment) {
        print("new assignment added")
        let newRowIndex = assignments.count
        
        assignments.append(assignment)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newAssignment" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NewScheduleViewController
            controller.delegate = self
        }
    }
    
}









