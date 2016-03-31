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
    
    var title = ""
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "Title")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObjectForKey("Title") as! String
        super.init()
    }
    
    
    override init() {
        super.init()
    }
}