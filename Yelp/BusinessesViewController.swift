//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/12/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // instantiating the class prevents a nil value error from occuring in the tableview count section
    var businesses: [Business]! = [Business]()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // cues the table view to use autolayout to determine row height
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses![indexPath.row]
        
        return cell
        
    }
    
    



}
