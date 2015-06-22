//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASMainViewController: UIViewController {

    @IBOutlet weak var mapButton: ASAugmentedMenuButton!
    @IBOutlet weak var aboutButton: ASAugmentedMenuButton!
    @IBOutlet weak var addButton: ASAugmentedMenuButton!
    @IBOutlet weak var searchButton: ASAugmentedMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.mapButton.buttonColor = UIColor.dodgerBlueAugmentedColor()
        self.addButton.buttonColor = UIColor.blackAugmentedColor()
        self.aboutButton.buttonColor = UIColor.grayAugmentedColor()
        self.searchButton.buttonColor = UIColor.redAugmentedColor()

        self.mapButton.isActive = true
        
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
        let buttons = [mapButton, searchButton, aboutButton, addButton]
        for index in 0...3 {
            if (buttons[index].isActive) {
                buttons[index].isActive = false
            
                if index == buttons.count-1 {
                    buttons.first?.isActive = true
                } else {
                    buttons[index+1].isActive = true
                }
                
                break
            }
        }
    }
}

