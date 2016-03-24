//
//  NewItemViewController.swift
//  behAPPy
//
//  Created by block7 on 3/24/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class NewItemViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }

    @IBAction func done() {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText:NSString = titleTextField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = true
        return true
        
    }

}
