
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
    var points:[Int] = [0,0,0,0,0,0,0]
    



    @IBInspectable var startColor: UIColor = UIColor.greenColor()
    @IBInspectable var endColor: UIColor = UIColor.blueColor()
    

    var layerOne:CATextLayer!
    var layerTwo:CATextLayer!
    var layerThree:CATextLayer!
    var layerFour:CATextLayer!
    var layerFive:CATextLayer!
    var layerSix:CATextLayer!
    var layerSeven:CATextLayer!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let graphPointsDefault = NSUserDefaults.standardUserDefaults()
        graphPoints = graphPointsDefault.valueForKey("graphPoints") as! Array
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layerOne = CATextLayer()
        layerTwo = CATextLayer()
        layerThree = CATextLayer()
        layerFour = CATextLayer()
        layerFive = CATextLayer()
        layerSix = CATextLayer()
        layerSeven = CATextLayer()
        
        
        let frame1 = CGRect(x: 14, y:360, width: 15, height: 21)
        let frame2 = CGRect(x: 100, y:360, width: 15, height: 21)
        let frame3 = CGRect(x: 186, y:360, width: 15, height: 21)
        let frame4 = CGRect(x: 272, y:360, width: 15, height: 21)
        let frame5 = CGRect(x: 358, y:360, width: 15, height: 21)
        let frame6 = CGRect(x: 444, y:360, width: 15, height: 21)
        let frame7 = CGRect(x: 530, y:360, width: 15, height: 21)

        layerOne.frame = frame1
        layerTwo.frame = frame2
        layerThree.frame = frame3
        layerFour.frame = frame4
        layerFive.frame = frame5
        layerSix.frame = frame6
        layerSeven.frame = frame7

        layerOne.string = "M"
        layerTwo.string = "M"
        layerThree.string = "M"
        layerFive.string = "M"
        layerFour.string = "M"
        layerSix.string = "M"
        layerSeven.string = "M"

        layerOne.fontSize = 17
        layerTwo.fontSize = 17
        layerThree.fontSize = 17
        layerFour.fontSize = 17
        layerFive.fontSize = 17
        layerSix.fontSize = 17
        layerSeven.fontSize = 17

        layerOne.foregroundColor = UIColor.blackColor().CGColor
        layerTwo.foregroundColor = UIColor.blackColor().CGColor
        layerThree.foregroundColor = UIColor.blackColor().CGColor
        layerFour.foregroundColor = UIColor.blackColor().CGColor
        layerFive.foregroundColor = UIColor.blackColor().CGColor
        layerSix.foregroundColor = UIColor.blackColor().CGColor
        layerSeven.foregroundColor = UIColor.blackColor().CGColor

        self.layer.addSublayer(layerOne)
        self.layer.addSublayer(layerTwo)
        self.layer.addSublayer(layerThree)
        self.layer.addSublayer(layerFour)
        self.layer.addSublayer(layerFive)
        self.layer.addSublayer(layerSix)
        self.layer.addSublayer(layerSeven)
        
        

        
    }
    
    override func drawRect(rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        
//        var graphPoints = NSUserDefaults.standardUserDefaults().objectForKey("graphPoints") as! [Int]
//        NSUserDefaults.standardUserDefaults().setObject(points, forKey: "graphPoints")
//        print("graph points: \(graphPoints)")

        
        var path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8.0, height: 8.0))
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
            
        let topBorder:CGFloat = 96
        let bottomBorder:CGFloat = 80
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()
        var columnYPoint = {(graphPoint:Int) -> CGFloat in
            var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        var graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        CGContextSaveGState(context)
        var clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLineToPoint(CGPoint(x:columnXPoint(graphPoints.count - 1), y:height))
        clippingPath.addLineToPoint(CGPoint(x:columnXPoint(0),y: height))
        clippingPath.closePath()
        clippingPath.addClip()
        
        
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, [])
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
        
        var linePath = UIBezierPath()
        
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























