//
//  AssignmentItem.swift
//  behAPPy
//
//  Created by Mia Fryling on 4/9/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation

@objc
class AssignmentItem: NSObject, NSCoding {
    
    var title: String?
    var notes: String?
    var userIsEditing = false
    var dueDate = NSDate()
    var shouldRemind: Bool = false
    var assignmentID: Int
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeObject(notes, forKey: "Notes")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(assignmentID, forKey: "AssignmentID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Title") as? String
        notes = aDecoder.decodeObjectForKey("Notes") as? String
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        
        if let sr = aDecoder.decodeObjectForKey("ShouldRemind") as? Bool {
            shouldRemind = sr
        }
        
        if let aid = aDecoder.decodeObjectForKey("AssignmentID") as? Int {
            assignmentID = aid
        } else {
            assignmentID = 0
        }

        super.init()
    }
    
    override init() {
        assignmentID = DataModel.nextAssignmentID()
        super.init()
    }
    
}