//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ASMapViewController: BLSAugmentedViewController, BLSAugmentedViewControllerDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate {
    
    var isConnectedToNetwork: Bool?
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var mapChoiceSegmentedControl: UISegmentedControl!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "ASPOI")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: ASData.sharedInstance.mainContext!,
            sectionNameKeyPath: "ASPOI.id",
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
        }()
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch (type) {
            
        case .Insert:
            fetchedResultsChangeInsert(anObject)
            break;
        case .Delete:
            fetchedResultsChangeDelete(anObject)
            break;
        case .Update:
            fetchedResultsChangeUpdate(anObject)
            break;
        default:
            break;
        }
        
    }
    
    private func fetchedResultsChangeInsert(anObject: AnyObject) {
        if let poiObject = anObject as? ASPOI {
            let annotation = ASAnnotation(poi: poiObject)
            self.addAnnotation(annotation)
        }
        
    }
    
    private func fetchedResultsChangeDelete(anObject: AnyObject) {
        if let poiObject = anObject as? ASPOI {
            let annotation = ASAnnotation(poi: poiObject)
            self.removeAnnotation(annotation)
            
        }
    }
    
    private func fetchedResultsChangeUpdate(anObject: AnyObject) {
        fetchedResultsChangeDelete(anObject)
        fetchedResultsChangeInsert(anObject)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        isConnectedToNetwork = Reachability.isConnectedToNetwork()
        
        scaleLabel.backgroundColor = UIColor(hex: 0xb6b6b6, alpha: 1)
        scaleLabel.text = "500 m"
        scaleLabel.textColor = UIColor(hex: 0x212121, alpha: 1)
    }

    func augmentedViewController(augmentedViewController: BLSAugmentedViewController!, viewForAnnotation annotation: BLSAugmentedAnnotation!, forUserLocation location: CLLocation!, distance: CLLocationDistance) -> BLSAugmentedAnnotationView! {
        let annotationView = ASAnnotationView()
        
        if let annotation = annotation as? ASAnnotation {
            annotationView.addressLabel.text = annotation.title
            annotationView.distanceLabel.text = annotation.subtitle
            
            annotationView.image = UIImage(named: "pin.png")
        }
        
        return annotationView
    }
    
    @IBAction func homeButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let restUtil = ASRestUtil()
        
        restUtil.getAllPois({(anyObject: AnyObject?) -> Void in},
            callbackFailure: {(codeError: Int?, message: String) -> Void in})
        }
}