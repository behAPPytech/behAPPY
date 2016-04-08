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
    
    var title:String
//    var notes:String
//    var dueDate: NSDate
//    var priority: Inte    
    
    required init(title: String) {
        self.title = title
    }
    
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