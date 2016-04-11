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

class NewAssignmentViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: NewAssignmentViewControllerDelegate?
    var assignmentToEdit: AssignmentItem?
    var userIsEditing = false
    var dueDate = NSDate()
    var classes: String = ""
    var datePickerVisible = false
    var classPickerVisible = false
    var pickerData:[String] = [String]()
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var cancelButton: UIBarButtonItem!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var textView: UITextView!
    @IBOutlet var reminderSwitch: UISwitch!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var classPickerCell: UITableViewCell!
    @IBOutlet var classPicker: UIPickerView!
    @IBOutlet weak var classLabel: UILabel!
    
    
    
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
            if assignment.shouldRemind == true {
                reminderSwitch.on = true
            } else {
                reminderSwitch.on = false
            }
            dueDate = assignment.dueDate
            updateDueDateLabel()
            classes = assignment.classes!
            updateClassLabel()
        }
        updateDueDateLabel()
        updateClassLabel()
        self.classPicker.delegate = self
        self.classPicker.dataSource = self
        pickerData = ["Math", "Science", "History", "English", "Language", "Other"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classes = pickerData[row]
        updateClassLabel()
        return
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
                assignment.shouldRemind = reminderSwitch.on
                assignment.dueDate = dueDate
                assignment.classes = classes
                assignment.scheduleNotification()
                delegate?.addAssignment(self, didFinishEditingAssignment: assignment)
                assignment.userIsEditing = false
                userIsEditing = false
                hideDatePicker()
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
            assignment.shouldRemind = reminderSwitch.on
            assignment.dueDate = dueDate
            assignment.classes = classes
            assignment.scheduleNotification()
            delegate?.addAssignment(self, didFinishAddingAssignment: assignment)
        }
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 && indexPath.row == 1 {
            return indexPath
        } else if indexPath.section == 2 && indexPath.row == 0 {
            return indexPath
        } else {
            return nil
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
        doneButton.enabled = (newText.length > 0)
        return true
    }
    
    func showClassPicker() {
        classPickerVisible = true
        let indexPathClassRow = NSIndexPath(forRow: 0, inSection: 2)
        let indexPathClassPicker = NSIndexPath(forRow: 1, inSection: 2)
        if let dateCell = tableView.cellForRowAtIndexPath(indexPathClassRow) {
            dateCell.detailTextLabel!.textColor = dateCell.detailTextLabel!.tintColor
        }
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPathClassPicker], withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([indexPathClassRow], withRowAnimation: .None)
        tableView.endUpdates()
        datePicker.setDate(dueDate, animated: false)
    }
    
    func hideClassPicker() {
        if classPickerVisible {
            classPickerVisible = false
            let indexPathClassRow = NSIndexPath(forRow: 0, inSection: 2)
            let indexPathClassPicker = NSIndexPath(forRow: 1, inSection: 2)
            if let cell = tableView.cellForRowAtIndexPath(indexPathClassRow) {
                cell.detailTextLabel!.textColor = UIColor(white: 0, alpha: 0.5)
            }
            
            tableView.beginUpdates()
            tableView.reloadRowsAtIndexPaths([indexPathClassRow], withRowAnimation: .None)
            tableView.deleteRowsAtIndexPaths([indexPathClassPicker], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }
    
    
    func updateDueDateLabel() {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(dueDate)
    }
    
    func updateClassLabel() {
        print(classes)
        classLabel.text = "\(classes)"
    }
    
    func showDatePicker() {
        datePickerVisible = true
        let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 1)
        let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
        if let dateCell = tableView.cellForRowAtIndexPath(indexPathDateRow) {
            dateCell.detailTextLabel!.textColor = dateCell.detailTextLabel!.tintColor
        }
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: .None)
        tableView.endUpdates()
        datePicker.setDate(dueDate, animated: false)
    }
    
    func hideDatePicker() {
        if datePickerVisible {
            datePickerVisible = false
            let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 1)
            let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
            if let cell = tableView.cellForRowAtIndexPath(indexPathDateRow) {
                cell.detailTextLabel!.textColor = UIColor(white: 0, alpha: 0.5)
            }
            
            tableView.beginUpdates()
            tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: .None)
            tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        } else if indexPath.section == 2 && indexPath.row == 1 {
            return classPickerCell
        } else {
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible {
            return 3
        } else if section == 2 && classPickerVisible {
            return 2
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView,
                            heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 2 {
            return 217
        } else if indexPath.section == 2 && indexPath.row == 1 {
            return 217
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        if indexPath.section == 1 && indexPath.row == 1 {
            if !datePickerVisible {
                showDatePicker()
            } else {
                hideDatePicker()
            }
        } else if indexPath.section == 2 && indexPath.row == 0 {
            if !classPickerVisible {
                showClassPicker()
            } else {
                hideClassPicker()
            }
        }
    }
    
    override func tableView(tableView: UITableView,
                    var indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 2 {
            indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        } else if indexPath.section == 2 && indexPath.row == 1 {
            indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
        }
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)

    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        hideDatePicker()
        hideClassPicker()
    }
    
    @IBAction func dateChanged(datePicker: UIDatePicker) {
        dueDate = datePicker.date
        updateDueDateLabel()
    }
    
    
    @IBAction func shouldRemainToggled() {
        textField.resignFirstResponder()
        if reminderSwitch.on {
            let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert , .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        }
    }
    
    
    
    
}












