
//  GraphView.swift
//  behAPPy
//
//  Created by block7 on 3/4/16.
//  Copyright © 2016 block7. All rights reserved.
//
import Foundation
import UIKit

@IBDesignable class GraphView: UIView {
    var graphPoints:[Int] = [0,0,0,0,0,0,0]


    @IBInspectable var startColor: UIColor = UIColor.greenColor()
    @IBInspectable var endColor: UIColor = UIColor.blueColor()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(graphPoints, forKey: "points")
        aCoder.encodeObject(NSDate(), forKey: "date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let
            date = aDecoder.decodeObjectForKey("date") as? NSDate,
            points = aDecoder.decodeObjectForKey("points") as? [Int]
        {
            let calendar = NSCalendar.currentCalendar()
            let dateSaved = calendar.startOfDayForDate(date)
            let dateToday = calendar.startOfDayForDate(NSDate())
            let days = Int(round(dateToday.timeIntervalSinceDate(dateSaved) / (24.0 * 60.0 * 60.0)))
            
            if days < 7 {
                for idx in days..<7 {
                    graphPoints[idx - days] = points[idx]
                }
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let width = rect.width
        let height = rect.height

        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()

        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        
        var startPoint: CGPoint = CGPoint.zero
        var endPoint: CGPoint = CGPoint(x: 0, y: self.bounds.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [])
        
        let margin:CGFloat = 20.0
        let columnXPoint = { (column:Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / (CGFloat(self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
            
        let topBorder:CGFloat = 60
        let bottomBorder:CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()!
        let columnYPoint = {(graphPoint:Int) -> CGFloat in
            var y:CGFloat = maxValue > 0 ? CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight : 0.0
            y = graphHeight + topBorder - y
            return y
        }
        
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        let graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        CGContextSaveGState(context)
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLineToPoint(CGPoint(x:columnXPoint(graphPoints.count - 1), y:height))
        clippingPath.addLineToPoint(CGPoint(x:columnXPoint(0),y: height))
        clippingPath.closePath()
        clippingPath.addClip()
        
        if maxValue > 0 {
            let highestYPoint = columnYPoint(maxValue)
            startPoint = CGPoint(x: margin, y: highestYPoint)
            endPoint = CGPoint(x: margin, y: self.bounds.height)
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [])
        }

        CGContextRestoreGState(context)
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        for i in 0..<graphPoints.count {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect:
                CGRect(origin: point,
                    size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        let linePath = UIBezierPath()
        
        linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y:topBorder))
        
        linePath.moveToPoint(CGPoint(x:margin, y: graphHeight/2 + topBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin, y:graphHeight/2 + topBorder))
        
        linePath.moveToPoint(CGPoint(x:margin, y:height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width - margin, y:height - bottomBorder))
        
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
        
        
    }

}























