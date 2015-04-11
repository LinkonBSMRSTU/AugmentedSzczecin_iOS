//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASMainViewController: BLSAugmentedViewController, BLSAugmentedViewControllerDelegate, CLLocationManagerDelegate {
    
    var isConnectedToNetwork: Bool?
    var currentLocation: CLLocationCoordinate2D?
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapChoiceSegmentedControl: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        
        isConnectedToNetwork = Reachability.isConnectedToNetwork()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        else{
            currentLocation = CLLocationCoordinate2DMake(53.4294687,14.5556164)
            self.setMapRegionWithTopLeftCoordinate(currentLocation!, andBottomRightCoordinate: currentLocation!, animated: false)
        }
    }
    
    func augmentedViewController(augmentedViewController: BLSAugmentedViewController!, viewForAnnotation annotation: BLSAugmentedAnnotation!, forUserLocation location: CLLocation!, distance: CLLocationDistance) -> BLSAugmentedAnnotationView! {
        return BLSAugmentedAnnotationView()
    }
    
    @IBAction func mapTypeChange(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            self.style = BLSAugmentedViewControllerStyle.Map
            self.setMapRegionWithTopLeftCoordinate(currentLocation!, andBottomRightCoordinate: currentLocation!, animated: false)
        } else if (sender.selectedSegmentIndex == 1) {
            self.style = BLSAugmentedViewControllerStyle.AR
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentLocation = manager.location.coordinate
        self.setMapRegionWithTopLeftCoordinate(currentLocation!, andBottomRightCoordinate: currentLocation!, animated: false)
        self.addAnnotation(ASAnnotation(type: "UserLocation", withCoordinate: currentLocation!))
    }
    
}