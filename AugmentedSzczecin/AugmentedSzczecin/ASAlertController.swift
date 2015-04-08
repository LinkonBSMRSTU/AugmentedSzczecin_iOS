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
    
    
    func show(vc: UIViewController) {
        vc.presentViewController(self, animated: true, completion: nil)
    }
    
    func showWithDelay(delay: Double, andVC vc: UIViewController){
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
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func dismiss(completion: ()->()) {
        
        self.dismissViewControllerAnimated(true, completion: completion)
    }
}