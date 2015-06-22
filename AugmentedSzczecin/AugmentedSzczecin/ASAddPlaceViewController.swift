//
//  ASAddPlaceViewController.swift
//  AugmentedSzczecin
//
//  Created by Grzegorz Pawlowicz on 31.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAddPlaceViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var streetNumberField: UITextField!
    @IBOutlet weak var houseNumberField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Name".localized
        streetTextField.placeholder = "Street".localized
        streetNumberField.placeholder = "Street number".localized
        houseNumberField.placeholder = "House number".localized
        zipCodeTextField.placeholder = "Zip Code".localized
        cityTextField.placeholder = "City".localized
        categoryTextField.placeholder = "Category".localized
        tagsTextField.placeholder = "Tags".localized
        
        categoryTextField.tintColor = UIColor.clearColor()
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        streetTextField.delegate = self
        streetNumberField.delegate = self
        houseNumberField.delegate = self
        zipCodeTextField.delegate = self
        cityTextField.delegate = self
        categoryTextField.delegate = self
        tagsTextField.delegate = self
        
        zipCodeTextField.keyboardType = UIKeyboardType.NumberPad
    }

    @IBAction func openCategoryPicker(sender: AnyObject) {
        self.performSegueWithIdentifier("showCategoryPickerSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }

    @IBAction func sendButtonTapped(sender: AnyObject) {
        var poi = ASPOI(managedObjectContext: ASData.sharedInstance.mainContext)
        if nameTextField.text != "" {
            poi.name = nameTextField.text
        }
        else {
            return
        }
        if streetTextField.text != "" {
            poi.street = streetTextField.text
        }
        else {
            return
        }
        if streetNumberField.text != "" {
            poi.streetNumber = streetNumberField.text
        }
        if houseNumberField.text != "" {
            poi.houseNumber = houseNumberField.text
        }
        if zipCodeTextField.text != "" {
            poi.zipCode = zipCodeTextField.text
        }
        else {
            return
        }
        if cityTextField.text != "" {
            poi.city = cityTextField.text
        }
        else {
            return
        }
        if categoryTextField.text != "" {
            poi.subcategory = categoryTextField.text
        }
        else {
            return
        }
        if tagsTextField.text != "" {
            poi.tag = tagsTextField.text
        }
        else {
            return
        }
        if descriptionTextView.text != "" {
            poi.desription = descriptionTextView.text
        }
        else {
            return
        }
    }

    @IBAction func categoryButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showCategoryPickerSegue", sender: nil)
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            switch textField.tag {
            case 101:
                if count(textField.text) == 50 {
                    return false;
                }
                return true
            case 102:
                if count(textField.text) == 60 {
                    return false;
                }
                return true
            case 103:
                if count(textField.text) == 10 {
                    return false;
                }
                return true
            case 104:
                if count(textField.text) == 5 {
                    return false;
                }
                return true
            case 105:
                if count(textField.text) == 30 {
                    return false;
                }
                return true
            case 106:
                if (string.toInt() == nil) {
                    return false
                }
                if count(textField.text) == 2 {
                    textField.text = "\(textField.text)-"
                    return true
                }
                if count(textField.text) == 6 {
                    return false;
                }
                return true
            default:
                return true
            }
        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if count(textView.text) == 500 && text != ""{
            return false
        }
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCategoryPickerSegue"
        {
            if let destinationVC = segue.destinationViewController as? ASCategoryPickerViewController
            {
                destinationVC.changeBlock = { categoryString in
                    self.categoryTextField.text = categoryString
                }

            }
        }
    }

}
