//
//  NewAssignmentViewController.swift
//  behAPPy
//
//  Created by Mia Fryling on 4/9/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

protocol NewAssignmentViewControllerDelegate: class {
    func addAssignment(controller: NewAssignmentViewController, didFinishAddingAssignment assignment: AssignmentItem)
    func addAssignment(controller: NewAssignmentViewController, didFinishEditingAssignment assignment: AssignmentItem)
}

class NewAssignmentViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: NewAssignmentViewControllerDelegate?
    var assignmentToEdit: AssignmentItem?
    var userIsEditing = false
    var dueDate = NSDate()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let assignment = assignmentToEdit {
            textField.text = assignment.title
            textView.text = assignment.notes
            doneButton.enabled = true
            doneButton.title = "Edit"
            cancelButton.title = "Back"
            textField.enabled = false
            textView.editable = false
            textView.selectable = false
            reminderSwitch.on = assignment.shouldRemind
            dueDate = assignment.dueDate
        }
        updateDueDateLabel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        if userIsEditing == true {
            cancelButton.title = "Back"
            doneButton.title = "Edit"
            userIsEditing = false
            textView.editable = false
            textView.selectable = false
            textField.enabled = false
            userIsEditing = false
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func done() {
        if let assignment = assignmentToEdit {
            if userIsEditing == true {
                cancelButton.title = "Back"
                doneButton.title = "Edit"
                textView.editable = false
                textView.selectable = false
                textField.enabled = false
                assignment.notes = textView.text
                assignment.title = textField.text!
                assignment.userIsEditing = true
                reminderSwitch.on = assignment.shouldRemind
                dueDate = assignment.dueDate
                delegate?.addAssignment(self, didFinishEditingAssignment: assignment)
                print("did edit assignment")
                assignment.userIsEditing = false
                userIsEditing = false
            } else {
                cancelButton.title = "Cancel"
                doneButton.title = "Done"
                userIsEditing = true
                textView.editable = true
                textView.selectable = true
                textField.enabled = true
            }
        } else {
            let assignment = AssignmentItem()
            assignment.title = textField.text
            assignment.notes = textView.text
            reminderSwitch.on = assignment.shouldRemind
            dueDate = assignment.dueDate
            delegate?.addAssignment(self, didFinishAddingAssignment: assignment)
        }
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
        doneButton.enabled = (newText.length > 0)
        return true
    }
    
    func updateDueDateLabel() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(dueDate)
    }
   
    
}