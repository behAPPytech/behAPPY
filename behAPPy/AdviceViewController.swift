//
//  HTMLViewController.swift
//  S.O.S.
//
//  Created by Marianne on 4/18/16.
//  Copyright © 2016 block7. All rights reserved.
//

import UIKit

class AdviceViewController: UIViewController {
    
    @IBOutlet weak var webVIew: UIWebView!
    
    override func viewDidLoad() {
        let url = NSBundle.mainBundle().URLForResource("advice", withExtension:"html")
        let request = NSURLRequest(URL: url!)
        webVIew.loadRequest(request)
    }
    
}
