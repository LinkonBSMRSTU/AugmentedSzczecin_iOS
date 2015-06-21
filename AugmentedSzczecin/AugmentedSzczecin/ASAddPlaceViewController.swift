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
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Name".localized
        streetTextField.placeholder = "Street".localized
        zipCodeTextField.placeholder = "Zip Code".localized
        cityTextField.placeholder = "City".localized
        categoryTextField.placeholder = "Category".localized
        tagsTextField.placeholder = "Tags".localized
        
        categoryTextField.tintColor = UIColor.clearColor()
        closeButton.setTitle("Close".localized, forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.mediumBlueAugmentedColor(), forState: UIControlState.Normal)
        
    }

    @IBAction func openCategoryPicker(sender: AnyObject) {
        self.performSegueWithIdentifier("showCategoryPickerSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
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
