//
//  SquareView.swift
//  behAPPy
//
//  Created by block7 on 4/15/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class SquareView: UIView {
    
    @IBOutlet var label: UILabel!
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.purpleColor().CGColor)
        let rectangle = CGRectMake(50,50,200,14)
        CGContextAddRect(context, rectangle)
        CGContextFillPath(context)
        
        let context1 = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context1, 1.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.purpleColor().CGColor)
        let rectangle1 = CGRectMake(50,242,200,14)
        CGContextAddRect(context1, rectangle1)
        CGContextFillPath(context1)

        let context2 = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context2, 1.0)
        CGContextSetStrokeColorWithColor(context2,
            UIColor.purpleColor().CGColor)
        let rectangle2 = CGRectMake(50,50,14,200)
        CGContextAddRect(context2, rectangle2)
        CGContextFillPath(context2)

        let context3 = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context3, 1.0)
        CGContextSetStrokeColorWithColor(context3,
            UIColor.purpleColor().CGColor)
        let rectangle3 = CGRectMake(242,50,14,200)
        CGContextAddRect(context3, rectangle3)
        CGContextFillPath(context3)

        
        let fillColor: UIColor = UIColor.greenColor()
        let rectange = CGRectMake(43, 242, 15, 15)
        let path = UIBezierPath(ovalInRect: rectange)
        fillColor.setFill()
        path.fill()
        
        
    }
    
}