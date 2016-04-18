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
    @IBOutlet var timesLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    
    let blueColor = UIColor(red: 0.3569, green: 0.4863, blue: 1, alpha: 1.0) /* #5b7cff */
    let lighterBlue = UIColor(red: 0.4784, green: 0.5725, blue: 1, alpha: 1.0) /* #7a92ff */
    let lightestBlue = UIColor(red: 0.6, green: 0.6706, blue: 1, alpha: 1.0) /* #99abff */
    let white = UIColor(red: 0.7098, green: 0.7608, blue: 1, alpha: 1.0) /* #b5c2ff */

    private var _animatedViews = [UIView]()
    var loopCount = 0

    
    @IBAction func animate() {
//        guard let number = Int(timesLabel.text!) else {
//            return
//        }
        runAnimation()
    }
    
    private func runAnimation() {
//        guard loopCount > 0 else {
//            startButton.enabled = true
//            return
//        }
        
        self.label.text = "Breath In..."
        self.animateViewFromFrame(CGRect(x: 41.5, y: 242.5, width: 15, height: 1), toFrame: CGRectMake(42.5, 42.5, 15, 200), color: self.blueColor) { [weak self] () -> Void in
            self?.label.text = "Hold"
            let viewToFadeOut = self?._animatedViews[0]
            UIView.animateWithDuration(12.0, animations: {
                viewToFadeOut?.alpha = 0.0
            })
            self?.animateViewFromFrame(CGRect(x: 57.5, y: 42.5, width: 1, height: 15), toFrame: CGRectMake(57.5, 42.5, 200, 15), color: self!.lighterBlue) {
                self?.label.text = "Breath Out..."
                let viewToFadeOut = self?._animatedViews[1]
                UIView.animateWithDuration(12.0, animations: {
                    viewToFadeOut?.alpha = 0.0
                })
                self?.animateViewFromFrame(CGRect(x: 242.5, y: 57.5, width: 15, height: 1), toFrame: CGRectMake(242.5, 57.2, 15, 200), color: self!.lightestBlue) {
                    self?.label.text = "Rest"
                    let viewToFadeOut = self?._animatedViews[2]
                    UIView.animateWithDuration(12.0, animations: {
                        viewToFadeOut?.alpha = 0.0
                    })
                    self?.animateViewFromFrame(CGRect(x: 241.2, y: 242.2, width: 1, height: 15), toFrame: CGRectMake(42.5, 242.5, 200, 15), color: self!.white)
                    {
                        self?.loopCount = (self!.loopCount) + 1
                        self?.timesLabel.text = "\(self!.loopCount)"
                        self?.runAnimation()
                        let otherViewToFadeOut = self?._animatedViews[3]
                        UIView.animateWithDuration(12.0, animations: {
                            otherViewToFadeOut?.alpha = 0.0
                        })
                        
                        self!._animatedViews.removeAtIndex(3)
                        self!._animatedViews.removeAtIndex(2)
                        self!._animatedViews.removeAtIndex(1)
                        self!._animatedViews.removeAtIndex(0)
                    }
                    
                }
            }
        }
        
    }
    
    private func animateViewFromFrame(frame0: CGRect, toFrame frame1: CGRect, color: UIColor, completionHandler: (() -> Void)?) {
        startButton.enabled = false
        let animatedView = UIView(frame: frame0)
        animatedView.backgroundColor = color
        _animatedViews.append(animatedView)
        addSubview(animatedView)
        
        UIView.animateWithDuration(4.0, animations: {
            animatedView.frame = frame1
        }) { (finished) in
            completionHandler?()
        }
    }
    
}