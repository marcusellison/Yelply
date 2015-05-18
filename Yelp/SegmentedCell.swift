//
//  SegmentedCell.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/16/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

@objc protocol SegmentedCellDelegate {
    optional func  segmentedCell( switchCell: SegmentedCell, didChangeValue value: Bool)
}

class SegmentedCell: UITableViewCell {
    
    @IBOutlet weak var segmentedValueLabel: UILabel!
    
    @IBOutlet weak var segmentedCellValue: UISegmentedControl!
    
    weak var delegate: SegmentedCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        segmentedCellValue.addTarget(self, action: "segmentedValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state 
    }
    
    func segmentedValueChanged() {
        delegate?.segmentedCell?(self, didChangeValue: segmentedCellValue.selected)
    }

}
