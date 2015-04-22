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
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("RegisterSegue", sender: nil)
        
        //MOCK
        
        var email = "tbilski@wi.zut.edu.pl"
        var password = "haslo1234"
        
        let restUtilTask = ASRestUtil()
        restUtilTask.signUp(email, password: password, callbackSuccess: {(user: AnyObject?) -> Void in
            
            let _user = user as? ASUser
            
            println("Zarejestrowano pomyslnie uzytkownika")
            println("Email: \(_user!.email!)")
            println("Password: \(_user!.password!)")
            println("Id: \(_user!.id!)")
            
            
            },
            callbackFailure: {(codeError: Int?, message: String) -> Void in
                
                
                println("code: \(codeError != nil ? codeError! : codeError), message: \(message)")
        })
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.setTitle("Register".localized, forState: UIControlState.Normal)
        cancelButton.setTitle("Cancel".localized, forState: UIControlState.Normal)
        
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

