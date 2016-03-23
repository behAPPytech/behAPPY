//
//  ScheduleDetailViewController.swift
//  behAPPy
//
//  Created by block7 on 3/22/16.
//  Copyright © 2016 block7. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var assignment: Assignment! {
        didSet (newAssignment) {
            changeLabels()
        }
    }

    func changeLabels() {
        nameLabel?.text = assignment.title
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ScheduleDetailViewController: AssignmentSelectDelegate {
    func assignmentSelected(newAssignment: Assignment) {
        assignment = newAssignment
    }
}