//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/14/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController:FiltersViewController, didUpdateFilters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var onCancelButton: UIBarButtonItem! // is this necessary (not in video)
    
    weak var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String:String]]!
    var switchStates = [Int: Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//      categories = yelpCategories()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var filters = [String: anyObject]()
        
        var selectedCategories = [String]()
        for (row,isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
            
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if categories != nil {
            return categories.count
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as? SwitchCell
        
//      cell!.switchLabel.text = categories[indexPath.row]["name"]
        
        cell.delegate = self
        
        cell.onSwitch.on = switchCell[indexPath.row] ?? false
        
        func switchCell(switchCell: SwitchCell,
            didChangeValue value: Bool) {
            let indexPath = tableView.indexPathForCell(switchCell)!
                
            switchStates[indexPath.row] = value
//            println("filters view controller got the switch event")
        }
        
        return cell
    }

}
