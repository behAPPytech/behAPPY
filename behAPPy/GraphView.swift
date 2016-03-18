
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
    
    let daysLayer:CATextLayer!
    let daysLayer1:CATextLayer!
    let daysLayer2:CATextLayer!
    let daysLayer3:CATextLayer!
    let daysLayer4:CATextLayer!
    let daysLayer5:CATextLayer!
    let daysLayer6:CATextLayer!


    @IBInspectable var startColor: UIColor = UIColor.greenColor()
    @IBInspectable var endColor: UIColor = UIColor.blueColor()
    
    var label1:UILabel = UILabel()
    var label2:UILabel = UILabel()
    var label3:UILabel = UILabel()
    var label4:UILabel = UILabel()
    var label5:UILabel = UILabel()
    var label6:UILabel = UILabel()
    var label7:UILabel = UILabel()
    
    

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

        let frame1 = CGRect(x: 14, y: 352, width: 16, height: 21)
        let frame2 = CGRect(x: 100, y: 352, width: 16, height: 21)
        let frame3 = CGRect(x: 186, y: 352, width: 16, height: 21)
        let frame4 = CGRect(x: 272, y: 352, width: 16, height: 21)
        let frame5 = CGRect(x: 358, y: 352, width: 16, height: 21)
        let frame6 = CGRect(x: 444, y: 352, width: 16, height: 21)
        let frame7 = CGRect(x: 530, y: 352, width: 16, height: 21)
        
        daysLayer.frame = frame1
        daysLayer1.frame = frame2
        daysLayer2.frame = frame3
        daysLayer3.frame = frame4
        daysLayer4.frame = frame5
        daysLayer5.frame = frame6
        daysLayer6.frame = frame7
        
        daysLayer.string = "M"
        daysLayer1.string = "M"
        daysLayer2.string = "M"
        daysLayer3.string = "M"
        daysLayer4.string = "M"
        daysLayer5.string = "M"
        daysLayer6.string = "M"
        
        createLabels()
        
        

        
    
    }

    func createLabels() {
        
//        let margin1:CGFloat = 20.0
//        let columnXPoint1 = { (column:Int) -> CGFloat in
//            let spacer = (width - margin1*2 - 4) / (CGFloat(self.graphPoints.count - 1))
//            var x:CGFloat = CGFloat(column) * spacer
//            x += margin + 2
//            return x
//        }
        
//        label1.frame = CGRectMake(14, 352, 16, 21)
//        label2.frame = CGRectMake(100, 352, 16, 21)
//        label3.frame = CGRectMake(186, 352, 16, 21)
//        label4.frame = CGRectMake(272, 352, 16, 21)
//        label5.frame = CGRectMake(358, 352, 16, 21)
//        label6.frame = CGRectMake(444, 352, 16, 21)
//        label7.frame = CGRectMake(530, 352, 16, 21)
//        
//        label1.textColor = UIColor.blackColor()
//        label2.textColor = UIColor.blackColor()
//        label3.textColor = UIColor.blackColor()
//        label4.textColor = UIColor.blackColor()
//        label5.textColor = UIColor.blackColor()
//        label6.textColor = UIColor.blackColor()
//        label7.textColor = UIColor.blackColor()
//        
//        label1.text = "M"
//        label2.text = "M"
//        label3.text = "M"
//        label4.text = "M"
//        label5.text = "M"
//        label6.text = "M"
//        label7.text = "M"
//        
//        label1.tag = 1
//        label2.tag = 2
//        label3.tag = 3
//        label4.tag = 4
//        label5.tag = 5
//        label6.tag = 6
//        label7.tag = 7
//        
//        
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        self.addSubview(label4)
        self.addSubview(label5)
        self.addSubview(label6)
        self.addSubview(label7)

        
       
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        
        //        var graphPoints = NSUserDefaults.standardUserDefaults().objectForKey("graphPoints") as! [Int]
//        NSUserDefaults.standardUserDefaults().setObject(points, forKey: "graphPoints")
//        print("graph points: \(graphPoints)")
        createLabels()
        

        
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























