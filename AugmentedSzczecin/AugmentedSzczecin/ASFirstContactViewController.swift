//
//  ASFirstContactViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 14.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASFirstContactViewController: UIViewController {

    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func showRegistrationViewController(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowRegistration", sender: nil)
    }
    
    @IBAction func skipAndGoToMainViewController(sender: AnyObject) {
        self.performSegueWithIdentifier("SkipAndGoToMainViewController", sender: nil)
    }
    override func viewDidLoad() {
<<<<<<< HEAD
        registerButton.setTitle("Załóż konto".localized, forState: UIControlState.Normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.redAugmentedColor().CGColor
        registerButton.layer.cornerRadius = 5
        //registerButton.layer.masksToBounds = true
        
=======
        registerButton.setTitle("Register".localized, forState: UIControlState.Normal)
        skipButton.setTitle("Skip".localized, forState: UIControlState.Normal)

>>>>>>> master
    }
    
}
