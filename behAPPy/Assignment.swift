//
//  Assignments.swift
//  behAPPy
//
//  Created by block7 on 3/22/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class Assignment: NSObject {
    
    var title = ""
    var notes = ""
//    var dueDate: NSDate
//    var priority: Int
    

    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Title")
//        aCoder.encodeObject(notes, forKey: "Notes")

    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Title") as! String
//        notes  = aDecoder.decodeObjectForKey("Notes") as! String
        super.init()
    }
    
}