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
    
    
    @IBAction func searchButtonTap(sender: AnyObject) {
        self.performSegueWithIdentifier("searchSegue", sender: nil)
    }

    @IBAction func showMapButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showMapSegue", sender: nil)
        }
    
}
