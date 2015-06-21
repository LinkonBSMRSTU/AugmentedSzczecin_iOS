//
//  ASRegistrationViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 14.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASRegistrationViewController: UIViewController, UITextFieldDelegate {

    let kAlertDelay = 2.0

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var loadingAlert: ASAlertController?
    var errorAlert: ASAlertController?
    var success = true;
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func registerButtonTapped(sender: AnyObject) {
        loadingAlert = ASAlertController(title: "Rejestruję", message: "Proszę czekać", preferredStyle: .Alert)
        loadingAlert?.showWithDelay(kAlertDelay, inViewController: self)
        //request to api
        if(success == true) {
            loadingAlert?.dismiss() {
                NSLog("success")
                self.performSegueWithIdentifier("RegisterSegue", sender: nil)
            }
        }
        else {
            loadingAlert?.dismiss() {
                self.errorAlert = ASAlertController(title: "Błąd", message: "Sprawdz swoje połączenie z Internetem", preferredStyle: .Alert)
                self.errorAlert?.addCancelAction("Zamknij")
                self.errorAlert?.showInViewController(self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.setTitle("Register".localized, forState: UIControlState.Normal)
        cancelButton.setTitle("Cancel".localized, forState: UIControlState.Normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.redAugmentedColor().CGColor
        registerButton.layer.cornerRadius = 5
        
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.redAugmentedColor().CGColor
        cancelButton.layer.cornerRadius = 5
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}

