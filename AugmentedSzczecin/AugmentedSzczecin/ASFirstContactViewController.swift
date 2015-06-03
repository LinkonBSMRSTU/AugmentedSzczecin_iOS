//
//  ASFirstContactViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 14.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASFirstContactViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    @IBAction func showRegistrationViewController(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowRegistration", sender: nil)
    }
    
    override func viewDidLoad() {
        registerButton.setTitle("Załóż konto".localized, forState: UIControlState.Normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.redAugmentedColor().CGColor
        registerButton.layer.cornerRadius = 5
        //registerButton.layer.masksToBounds = true
        
    }
    
}
