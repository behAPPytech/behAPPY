//
//  HTMLViewController.swift
//  S.O.S.
//
//  Created by Marianne on 4/18/16.
//  Copyright © 2016 block7. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        let url = NSBundle.mainBundle().URLForResource("resources", withExtension:"html")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
}
