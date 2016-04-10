//
//  AssignmentListsViewController.swift
//  behAPPy
//
//  Created by Mia Fryling on 4/9/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class AssignmentsViewController: UITableViewController, NewAssignmentViewControllerDelegate {
    
    var assignments: [AssignmentItem]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    required init?(coder aDecoder: NSCoder) {
        assignments = [AssignmentItem]()
        super.init(coder: aDecoder)
        loadAssignments()
    }
    
    func loadAssignments() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                assignments = unarchiver.decodeObjectForKey("AssignmentItems") as! [AssignmentItem]
                unarchiver.finishDecoding()
            }
        }
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        let directory = documentsDirectory() as NSString
        return directory.stringByAppendingPathComponent("Assignments.plist")
    }

    func saveAssignments() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(assignments, forKey: "AssignmentItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentItem", forIndexPath: indexPath)
        let assignment = assignments[indexPath.row]
        
        configureTextForCell(cell, withAssignment: assignment)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func configureTextForCell(cell: UITableViewCell, withAssignment assignment: AssignmentItem) {
        let label = cell.viewWithTag(579) as! UILabel
        label.text = assignment.title
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        assignments.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveAssignments()
    }
    
    func addAssignment(controller: NewAssignmentViewController, didFinishAddingAssignment assignment: AssignmentItem) {
        let newRowIndex = assignments.count
        assignments.append(assignment)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        saveAssignments()
        dismissViewControllerAnimated(true, completion: nil)
    }

    func addAssignment(controller: NewAssignmentViewController, didFinishEditingAssignment assignment: AssignmentItem) {
        if let index = assignments.indexOf(assignment) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withAssignment: assignment)
            }
        }
        saveAssignments()
        if assignment.userIsEditing == false {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newAssignment" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NewAssignmentViewController
            controller.delegate = self
        } else if segue.identifier == "editAssignment" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NewAssignmentViewController
            controller.delegate = self
            
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.assignmentToEdit = assignments[indexPath.row]
            }
        }
    }
}




















