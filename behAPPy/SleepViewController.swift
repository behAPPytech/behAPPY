//
//  SleepViewController.swift
//  behAPPy
//
//  Created by block7 on 3/3/16.
//  Copyright © 2016 block7. All rights reserved.
//

import Foundation
import UIKit

class SleepViewController: UIViewController {
    
    var counter = 0
    @IBOutlet weak var CounterLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageSleep: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CounterLabel.text = String(counter)
        setupGraphDisplay()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counter = counter + 1
        } else {
            if counter == 0 {
                counter = 0
            } else if counter > 0 {
                counter = counter - 1
            }
        }
        CounterLabel.text = String(counter)
        setupGraphDisplay()
    }
    let average = 0
//    let averageWater = NSUserDefaults.standardUserDefaults().integerForKey(average) as! int
    
    func setupGraphDisplay() {
//        let noOfDays:Int = 7
        graphView.graphPoints[graphView.graphPoints.count-1] = counter
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
        NSUserDefaults.standardUserDefaults().setInteger(average, forKey: "averageSleep")
        averageSleep.text = "Average: \(average)"
        
//        let dateFormatter = NSDateFormatter()
        let calendar = NSCalendar.currentCalendar()
        let componentOptions:NSCalendarUnit = .Weekday
        let components = calendar.components(componentOptions, fromDate: NSDate())
        var weekday = components.weekday
        
        let days = ["S", "S", "M", "T", "W", "T", "F"]
        for i in Array((1...days.count).reverse()) {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday--]
                if weekday < 0 {
                    weekday = days.count - 1
                }
            }
        }
        
    }
    
    

}



