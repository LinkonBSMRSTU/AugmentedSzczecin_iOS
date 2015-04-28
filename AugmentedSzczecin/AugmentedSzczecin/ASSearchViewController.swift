//
//  ASSearchViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.04.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASSearchViewController: UITableViewController, UISearchResultsUpdating {
    let tableData = ["BLStream", "Kaskada", "Galaxy", "Zamek Książąt Pomorskich"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
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
        
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.active) {
            return self.filteredTableData.count
        }
        else {
            return self.tableData.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ASSearchCell", forIndexPath: indexPath) as! UITableViewCell
        
        if (self.resultSearchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row]
            
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if (searchController.searchBar.text != "") {
            
            filteredTableData.removeAll(keepCapacity: false)
            
            let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
            let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
            
            filteredTableData = array as! [String]
            
        } else {
            filteredTableData = tableData
        }
        self.tableView.reloadData()
    }
    
}