//
//  AssignmentItem.swift
//  behAPPy
//
//  Created by Mia Fryling on 4/9/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

@objc
class AssignmentItem: NSObject, NSCoding {
    
    var title: String?
    var notes: String?
    var userIsEditing = false
    var dueDate = NSDate()
    var shouldRemind: Bool = false
    var assignmentID: Int
    var classes: String?
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeObject(notes, forKey: "Notes")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(assignmentID, forKey: "AssignmentID")
        aCoder.encodeObject(classes, forKey: "Class")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Title") as? String
        notes = aDecoder.decodeObjectForKey("Notes") as? String
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        assignmentID = aDecoder.decodeIntegerForKey("AssignmentID")
        classes = aDecoder.decodeObjectForKey("Class") as? String
        super.init()
    }
    
    override init() {
        assignmentID = DataModel.nextAssignmentID()
        super.init()
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        for notification in allNotifications {
            if let number = notification.userInfo?["AssignmentID"] as? Int where number == assignmentID {
                return notification
            }
        }
        return nil
    }
    
    
    func scheduleNotification() {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
        if shouldRemind == true && dueDate.compare(NSDate()) != .OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = title
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["AssignmentID": assignmentID]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }
    
    deinit {
        if let notification = notificationForThisItem() {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
    
}