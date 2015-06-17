//
//  ASCategoryPickerViewController.swift
//  AugmentedSzczecin
//
//  Created by Grzegorz Pawlowicz on 03.06.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASCategoryPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    var categoryPickerDataSource = [String]()
    var selectedCategory: String!
    var changeBlock:((text: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPickerDataSource = ["SCHOOL", "HOSPITAL", "PARK", "MONUMENT", "MUSEUM", "OFFICE", "BUS_STATION", "TRAIN_STATION", "POST_OFFICE", "CHURCH"]
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBarButtonItemTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    // MARK: - UIPickerView
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryPickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoryPickerDataSource[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryPickerDataSource[row]
        self.changeBlock?(text: selectedCategory)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
