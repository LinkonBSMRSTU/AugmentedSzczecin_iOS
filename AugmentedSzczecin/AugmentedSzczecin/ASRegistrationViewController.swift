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
    var alert: ASAlertController?
    var success = false;
     
    @IBAction func registerButtonTapped(sender: AnyObject) {
        alert = ASAlertController(title: "Rejestruję", message: "Proszę czekać", preferredStyle: .Alert)
        alert?.showWithDelay(2, andVC: self)
        //request to api
        if(success == true) {
            alert?.stopTimer()
            alert?.dismiss({ () -> () in
                NSLog("info")
            })
            self.performSegueWithIdentifier("RegisterSegue", sender: nil)
        }
        else{
            alert?.stopTimer()
            alert = ASAlertController(title: "Błąd", message: "Sprawdz swoje połączenie z Internetem", preferredStyle: .Alert)
            alert?.addCancelAction("Zamknij")
            alert?.show(self)
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

