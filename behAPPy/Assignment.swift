//
//  Assignments.swift
//  behAPPy
//
//  Created by block7 on 3/22/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class Assignment: NSObject, NSCoding {
    
    var title:String
//    var notes:String
//    var dueDate: NSDate
//    var priority: Inte    
    
    required init(title: String) {
        self.title = title
<<<<<<< HEAD
//         self.notes = notes
        super.init()
=======
>>>>>>> 0c9191c3fed423cdbd9fead773201f570e6dbd9b
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