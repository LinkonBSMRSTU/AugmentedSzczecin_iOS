//
//  ASRegistrationViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 14.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASRegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var loadingAlert: ASAlertController?
    var errorAlert: ASAlertController?
    var success = true;
     
    @IBAction func registerButtonTapped(sender: AnyObject) {
        loadingAlert = ASAlertController(title: "Rejestruję", message: "Proszę czekać", preferredStyle: .Alert)
        loadingAlert?.showWithDelay(2, inViewController: self)
        //request to api
        if(success == true) {
            loadingAlert?.dismiss({ () -> () in
                NSLog("success")
            })
            self.performSegueWithIdentifier("RegisterSegue", sender: nil)
        }
        else {
            loadingAlert?.dismiss({ () -> () in
                NSLog("error")
            })
            errorAlert = ASAlertController(title: "Błąd", message: "Sprawdz swoje połączenie z Internetem", preferredStyle: .Alert)
            errorAlert?.addCancelAction("Zamknij")
            errorAlert?.showInViewController(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

