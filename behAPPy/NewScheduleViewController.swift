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
}

class NewScheduleViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesView: UITextView!
    
    weak var delegate: NewScheduleViewControllerDelegate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done() {
        print("done pressed")
        print(notesView.text)
        let assignment = Assignment(title: textView.text!)
        delegate?.newAssignment(self, didFinishAddingAssignment: assignment)
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
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