//
//  ASSearchViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import CoreData

class ASSearchViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    var resultSearchController = UISearchController()
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("dismissViewController"))
                
        self.tableView.reloadData()
        
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] as! NSFetchedResultsSectionInfo
            return currentSection.numberOfObjects
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] as! NSFetchedResultsSectionInfo
            return currentSection.name
        }
        
        return nil
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ASSearchCell", forIndexPath: indexPath) as! UITableViewCell

        let poi = fetchedResultsController.objectAtIndexPath(indexPath) as! ASPOI
            
            cell.textLabel?.text = poi.name
            cell.detailTextLabel?.text = poi.tag
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowDetailSegue", sender: fetchedResultsController.objectAtIndexPath(indexPath))
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if (searchController.searchBar.text != "") {
            
            var predicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            fetchedResultsController.fetchRequest.predicate = predicate
            fetchedResultsController.fetchRequest.fetchLimit = 25
            
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetailSegue") {
            var destination = segue.destinationViewController as! ASPointDetailViewController
            destination.POI = sender as? ASPOI
        }
    }
    
}