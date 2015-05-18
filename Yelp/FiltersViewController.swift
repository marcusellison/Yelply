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

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, SegmentedCellDelegate, RadiusCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var onCancelButton: UIBarButtonItem! // is this necessary (not in video)
    
    weak var delegate: FiltersViewControllerDelegate?
    
    let filterSections: [String] = ["Categories",  "Radius", "Sort", "Deals"]
    
    let radiusCategories: [String] = ["Auto", "1.0", "1.5", "2.0", "2.5", "3.0", "3.5"]
    let sortCategories: [String] = ["Best Match", "Distance", "Highest Rated"]
    
    // Lets define keys
    let dealsKey = "deals"
    let categoriesKey = "categories"
    let sortKey = "sort"
    
    // lets define cell types
    let cellTypes: [String: String] = [
        "switch": "SwitchCell",
        "radius": "RadiusCell",
        "sort": "SegmentedCell"
    ]
    
    let switchCellKey = 0
    let radiusCellKey = 1
    let sortCellKey = 2
    
    let dealsText = "Want Deals?"
    
    var categories: [[String:String]]!
    var switchStates = [NSIndexPath: Bool]()
    
    var deals = false
    var matchType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
      categories = yelpCategories()
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
        
        var filters = [String: AnyObject]()
        
        var selectedCategories = [String]()
        for ( indexPath, isSelected) in switchStates {
            if isSelected && indexPath.section == 0 {
                selectedCategories.append(categories[indexPath.row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        
        filters[dealsKey] = deals
        filters[sortKey] = matchType
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: AnyObject
        switch indexPath.section {
            
        case switchCellKey:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellTypes["switch"]!, forIndexPath: indexPath) as! SwitchCell
            
            cell.switchLabel.text = categories[indexPath.row]["name"]
            cell.onSwitch.on = switchStates[indexPath] ?? false
            cell.delegate = self
            return cell
            
        case sortCellKey:
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellTypes["radius"]!, forIndexPath: indexPath) as! RadiusCell
            
            cell.radiusLabel.text = sortCategories[indexPath.row]
            
            //            cell.onSwitch.hidden = true
            cell.onSwitch.on = switchStates[indexPath] ?? false
            
            
            if cell.onSwitch!.on {
                //                cell.accessoryView = UIImageView(image: UIImage(named: "SortSelected"))
                cell.accessoryType = .Checkmark
            } else {
                //                cell.accessoryView = UIImageView(image: UIImage(named: "SortDeselected"))
                cell.accessoryType = .None
            }
            
            cell.delegate = self
            return cell
            
        case radiusCellKey:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellTypes["radius"]!, forIndexPath: indexPath) as! RadiusCell
            
            cell.radiusLabel.text = radiusCategories[indexPath.row]
            
//            cell.onSwitch.hidden = true
            cell.onSwitch.on = switchStates[indexPath] ?? false
            
            //Almost implemented!
            if cell.onSwitch!.on {
//                cell.accessoryView = UIImageView(image: UIImage(named: "SortSelected"))
                cell.accessoryType = .Checkmark
            } else {
//                cell.accessoryView = UIImageView(image: UIImage(named: "SortDeselected"))
                cell.accessoryType = .None
            }
            
            cell.delegate = self
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellTypes["switch"]!, forIndexPath: indexPath) as! SwitchCell
            cell.switchLabel.text = dealsText
            cell.delegate = self
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        case 1:
            return radiusCategories.count
        case 2:
            return sortCategories.count
        default:
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        println("just switched a cell")
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        switch indexPath.section {
        case 0:
            switchStates[indexPath] = value
        default:
            deals = value
        }
    }
    
    
    // A false attempt to deselect rows
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if indexPath.section == 2 {
//            
//            // set the accessory view to all index paths to nil
//            // iterate through cells in section and set accessory cells to nothing.
//            // set indexpathpath just tapped to checkmark.
//            for (indexPath, bool) in indexPath {
//                cell.accessoryView = nil
//            }
//            
//            let currentCell = self.tableView.cellForRowAtIndexPath(indexPath) as! UITableViewCell
//            currentCell.accessoryView = .Check
//        }
//    }
    
    // radiusCelllDelegate
    func radiusCell(radiusCell: RadiusCell, valueUpdated: Bool) {
        matchType = tableView.indexPathForCell(radiusCell)!.row
    }
    
//    func  segmentedCell( switchCell: SegmentedCell, didChangeValue value: Bool) {
//        println("matchType")
//        matchType = self.didChangeValue
//    }
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["name" : "African", "code": "african"],
            ["name" : "Brazilian", "code": "brazilian"],
            ["name" : "Burgers", "code": "burgers"],
            ["name" : "American, New", "code": "newamerican"]
        ]

    }

}











