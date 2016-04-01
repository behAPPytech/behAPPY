//
//  AssignmentDetailsViewController.swift
//  behAPPy
//
//  Created by block7 on 3/31/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

protocol AssignmentDetailViewControllerDelegate: class {
    func updateTitle(controller: AssignmentDetailViewController)
}

class AssignmentDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
        
    weak var delegate: AssignmentDetailViewControllerDelegate?
    var itemToEdit: Assignment?
    var isChanging = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons()
        titleTextField.text = itemToEdit?.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateButtons() {
        
        if isChanging == false {
            editButton.title = "Edit"
            backButton.title = "Back"
            titleTextField.enabled = false
            notesTextView.editable = false
            notesTextView.selectable = false
        } else if isChanging == true {
            editButton.title = "Save"
            backButton.title = "Cancel"
        }
    }
    
    @IBAction func back() {
        if isChanging == false {
            dismissViewControllerAnimated(true, completion: nil)
        } else if isChanging == true {
            isChanging = false
            updateButtons()
        }
    }
    
    func save() {
        
    }
    
    @IBAction func edit() {
        if isChanging == false {
            isChanging = true
            updateButtons()
            titleTextField.enabled = true
            notesTextView.editable = true
            notesTextView.selectable = true
        } else if isChanging == true {
            save()
            isChanging = false
            updateButtons()
            titleTextField.enabled = false
            notesTextView.editable = false
            notesTextView.selectable = false
        }
    }

    
    
    
}