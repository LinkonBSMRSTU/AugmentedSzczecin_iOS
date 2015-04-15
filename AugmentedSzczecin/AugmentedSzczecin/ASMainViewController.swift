//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASMainViewController: BLSAugmentedViewController, BLSAugmentedViewControllerDelegate, MKMapViewDelegate {
    
    var isConnectedToNetwork: Bool?
    
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var mapChoiceSegmentedControl: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        
        isConnectedToNetwork = Reachability.isConnectedToNetwork()
        
        scaleLabel.backgroundColor = UIColor(hex: 0xb6b6b6, alpha: 1)
        scaleLabel.text = "500 m"
        scaleLabel.textColor = UIColor(hex: 0x212121, alpha: 1)
    }
    
    func augmentedViewController(augmentedViewController: BLSAugmentedViewController!, viewForAnnotation annotation: BLSAugmentedAnnotation!, forUserLocation location: CLLocation!, distance: CLLocationDistance) -> BLSAugmentedAnnotationView! {
        return BLSAugmentedAnnotationView()
    }
    
    @IBAction func mapTypeChange(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            self.style = BLSAugmentedViewControllerStyle.Map
        } else if (sender.selectedSegmentIndex == 1) {
            self.style = BLSAugmentedViewControllerStyle.AR
        }
    }
    
    override func shouldAutorotate() -> Bool {
        if (self.style == BLSAugmentedViewControllerStyle.Map) {
            return (UIApplication.sharedApplication().statusBarOrientation != UIInterfaceOrientation.Portrait) ;
        } else {
            return true
        }
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        mapView.showsUserLocation = true
        self.setMapRegionWithTopLeftCoordinate(userLocation.coordinate, andBottomRightCoordinate: userLocation.coordinate, animated: false)
    }
}