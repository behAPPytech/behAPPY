//
//  DataModel.swift
//  behAPPy
//
//  Created by Mia Fryling on 4/10/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation

class DataModel {
    
    func registerDefaults() {
        let dictionary = ["AssignmentID": 0 ]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    class func nextAssignmentID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let assignmentID = userDefaults.integerForKey("AssignmentID")
        userDefaults.setInteger(assignmentID + 1, forKey: "AssignmentID")
        userDefaults.synchronize()
        return assignmentID
    }
    
    
}