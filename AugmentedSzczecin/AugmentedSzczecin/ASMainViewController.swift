//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASMainViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var showMapButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var showAddPOI: UIButton!
    
    override func viewDidLoad() {
        
        searchButton.backgroundColor = UIColor.dodgerBlueAugmentedColor()
        searchButton.tintColor = UIColor.whiteAugmentedColor()
        searchButton.layer.cornerRadius = 50
        searchButton.layer.borderWidth = 5
        searchButton.layer.borderColor = UIColor.dodgerBlueAugmentedColor().CGColor
        
        showMapButton.backgroundColor = UIColor.clearColor()
        showMapButton.tintColor = UIColor.redAugmentedColor()
        showMapButton.layer.cornerRadius = 50
        showMapButton.layer.borderWidth = 5
        showMapButton.layer.borderColor = UIColor.redAugmentedColor().CGColor

        aboutButton.backgroundColor = UIColor.clearColor()
        aboutButton.tintColor = UIColor.grayAugmentedColor()
        aboutButton.layer.cornerRadius = 50
        aboutButton.layer.borderWidth = 5
        aboutButton.layer.borderColor = UIColor.grayAugmentedColor().CGColor
        
        showAddPOI.backgroundColor = UIColor.clearColor()
        showAddPOI.tintColor = UIColor.blackAugmentedColor()
        showAddPOI.layer.cornerRadius = 50
        showAddPOI.layer.borderWidth = 5
        showAddPOI.layer.borderColor = UIColor.blackAugmentedColor().CGColor
        
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("switchColor"), userInfo: nil, repeats: true)
    }
    
    @IBAction func searchButtonTap(sender: AnyObject) {
        self.performSegueWithIdentifier("searchSegue", sender: nil)
    }

    @IBAction func showMapButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showMapSegue", sender: nil)
        }
    
    @IBAction func aboutButtonTap(sender: AnyObject) {
        self.performSegueWithIdentifier("aboutSegue", sender: nil)
    }

    @IBAction func showAddPOITap(sender: AnyObject) {
        self.performSegueWithIdentifier("showAddPOISegue", sender: nil)
    }
    
    func switchColor() {
        let buttons = [showMapButton, searchButton, aboutButton, showAddPOI]
        for index in 0...3 {
            if (buttons[index].backgroundColor != UIColor.clearColor()) {
                
                UIView.animateWithDuration(0.6, animations: { () -> Void in
                    buttons[index].backgroundColor = UIColor.clearColor()
                    buttons[index].tintColor = UIColor(CGColor: buttons[index].layer.borderColor)
                    
                    if (index == buttons.count-1) {
                        buttons.first?.backgroundColor = UIColor(CGColor: buttons.first!.layer.borderColor)
                        buttons.first?.tintColor = UIColor.whiteAugmentedColor()
                    } else {
                        buttons[index+1].backgroundColor = UIColor(CGColor: buttons[index+1].layer.borderColor)
                        buttons[index+1].tintColor = UIColor.whiteAugmentedColor()
                        
                    }
                })
                
                break
            }
        }
    }
}

