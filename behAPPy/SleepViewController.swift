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
    
    @IBAction func btnPushButton(button: PushButtonView) {
        if button.isAddButton {
            counter = counter + 1
        } else {
            counter = counter - 1
        }
        CounterLabel.text = String(counter)
    }
    
    
}