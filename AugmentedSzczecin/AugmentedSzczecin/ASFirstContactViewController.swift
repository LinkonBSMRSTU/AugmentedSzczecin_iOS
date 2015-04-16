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
        loginButton.setTitle("Login".localized , forState: UIControlState.Normal)
        registerButton.setTitle("Register".localized, forState: UIControlState.Normal)
    }
    
}
