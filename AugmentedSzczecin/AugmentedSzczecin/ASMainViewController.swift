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
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("switchColor"), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setButton(showMapButton, color: UIColor.redAugmentedColor())
        self.setButton(aboutButton, color: UIColor.grayAugmentedColor())
        self.setButton(showAddPOI, color: UIColor.blackAugmentedColor())
        
        
        searchButton.backgroundColor = UIColor.dodgerBlueAugmentedColor()
        searchButton.tintColor = UIColor.whiteAugmentedColor()
        searchButton.layer.cornerRadius = searchButton.frame.width / 2
        searchButton.layer.borderWidth = 5
        searchButton.layer.borderColor = UIColor.dodgerBlueAugmentedColor().CGColor
        
    }
    
    func setButton(button: UIButton, color: UIColor) {
        button.backgroundColor = UIColor.clearColor()
        button.tintColor = color
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.borderWidth = 5
        button.layer.borderColor = color.CGColor
        button.layer.masksToBounds = true
        button.clipsToBounds = true
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

