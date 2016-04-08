//
//  NewScheduleViewController.swift
//  behAPPy
//
//  Created by block7 on 3/29/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

protocol NewScheduleViewControllerDelegate: class {
    func newAssignment(controller: NewScheduleViewController, didFinishAddingAssignment assignment: Assignment)
    func newScheduleViewController(controller: NewScheduleViewController, didFinishEditingAssignment assignment: Assignment)
}

class NewScheduleViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var datePickerCell: UITableViewCell!

    var dueDate = NSDate()
    var datePickerVisable = false
    
    weak var delegate: NewScheduleViewControllerDelegate?
    var assignmentToEdit: Assignment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let assignment = assignmentToEdit {
            textView.text = assignment.title
            doneBarButton.enabled = true
            title = "Edit Assignment"
        }
        updateDueDateLabels()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        if let assignment = assignmentToEdit {
            
            delegate?.newScheduleViewController(self, didFinishEditingAssignment: assignment)
        } else {
            let assignment = Assignment(title: textView.text!)
            delegate?.newAssignment(self, didFinishAddingAssignment: assignment)
        }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 2 && indexPath.row == 1 { return datePickerCell
    } else {
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisable {
            return 3
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return 217
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textView.resignFirstResponder()
        
        if indexPath.section == 1 && indexPath.row == 1 {
            showDatePicker()
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
            
        if indexPath.section == 1 && indexPath.row == 1 {
            indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        }
            
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
    }

    ￼￼￼￼￼￼￼￼￼￼￼￼￼￼   
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textView.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        if newText.length > 0 {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
        }
        
        return true
    }
    
    func updateDueDateLabels() {
        let formatter =  NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dateLabel.text = formatter.stringFromDate(dueDate)
    }
    
    func showDatePicker() {
        datePickerVisable = true
        let indexPathDatePicker = NSIndexPath(forRow: 1, inSection: 1)
        tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        
    }
    
}















