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
    @IBOutlet var CounterLabel: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var graphView: GraphView!
    @IBOutlet var averageSleep: UILabel!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = graphView.graphPoints.graphPoints.last!
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
        NSKeyedArchiver.archiveRootObject(graphView.graphPoints, toFile: dataFilePath())
    }

    let average = 0
//    let averageWater = NSUserDefaults.standardUserDefaults().integerForKey(average) as! int
    
    func setupGraphDisplay() {
//        let noOfDays:Int = 7
        let graphPoints = graphView.graphPoints
        graphPoints.graphPoints[graphPoints.graphPoints.count-1] = counter
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphPoints.graphPoints.maxElement()!)"
        let average = graphPoints.graphPoints.reduce(0, combine: +) / graphPoints.graphPoints.count
        NSUserDefaults.standardUserDefaults().setInteger(average, forKey: "averageSleep")
        averageSleep.text = "Average: \(average)"
        
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
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Graphpoints.plist")
    }

    

}



