//
//  ASAlertController.swift
//  AugmentedSzczecin
//
//  Created by Wojciech Tyziniec on 20/03/15.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import Foundation
import UIKit

class ASAlertController: UIAlertController
{
    var vc: UIViewController?
    var timer: NSTimer?
    
    func showInViewController(vc: UIViewController) {
        vc.presentViewController(self, animated: true, completion: nil)
    }
    
    func showWithDelay(delay: Double, inViewController vc: UIViewController){
        let indicator = UIActivityIndicatorView(frame: self.view.bounds)
        indicator.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.view.addSubview(indicator)
        indicator.userInteractionEnabled = false
        indicator.startAnimating()

        timer = NSTimer.schedule(delay: delay) { timer in
            vc.presentViewController(self, animated: true, completion: nil)
        }
    }
    
    func addCancelAction(buttonTitle: String) {
        let cancelAction = UIAlertAction(title: buttonTitle, style: .Cancel) { (action) in
            println("canceled")
        }
        self.addAction(cancelAction)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        self.timer = nil
    }
    
    func dismiss(completion: ()->()) {
        if self.timer != nil {
            self.stopTimer()
            completion()
        } else {
            self.dismissViewControllerAnimated(true, completion: completion)
        }
    }
}