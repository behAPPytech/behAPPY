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
    
    weak var delegate: NewScheduleViewControllerDelegate?
    var assignmentToEdit: Assignment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let assignment = assignmentToEdit {
            textView.text = assignment.title
            doneBarButton.enabled = true
            title = "Edit Assignment"
        }
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
            assignment.title = textView.text!
            delegate?.newScheduleViewController(self, didFinishEditingAssignment: assignment)
        } else {
            let assignment = Assignment()
            delegate?.newAssignment(self, didFinishAddingAssignment: assignment)
        }
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    
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
    
    
    
}