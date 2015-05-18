//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/12/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var businessSearchBar: UISearchBar!
    
    // instantiating the class prevents a nil value error from occuring in the tableview count section
    var businesses: [Business]! = [Business]()
    
    // search bar
    var businessSearchBar: UISearchBar?
    var searchActive : Bool = false
    var filtered: [Business] = [Business]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cues the table view to use autolayout to determine row height
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        //search bar
        self.businessSearchBar = UISearchBar(frame :CGRectMake(0, 0, 320, 64))
        businessSearchBar!.center = CGPointMake(160, 284)
        self.businessSearchBar!.delegate = self
        navigationItem.titleView = businessSearchBar
        
                Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
                    self.businesses = businesses
                    
                    // reload the tableView data once api call finishes
                    self.tableView.reloadData()
                    
                })
//        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            self.tableView.reloadData()
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            // if searchActive true return filtered.count otherwise return business.count
            return searchActive ? filtered.count : businesses.count
            
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        if searchActive {
            cell.business = filtered[indexPath.row]
        } else {
            cell.business = businesses![indexPath.row];
        }
        
//      cell.business = businesses![indexPath.row]
        
        return cell
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController:FiltersViewController, didUpdateFilters filters: [String: AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        
        Business.searchWithTerm("restaurants", sort: nil, categories: categories, deals: nil) { (businesses:[Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    // search bar functions
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(businessSearchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = businesses!.filter({ (text) -> Bool in
            let tmp: AnyObject? = text.name
            let range = tmp!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if filtered.count == 0 {
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        self.tableView.reloadData()
    }
    
    



}
