//
//  DistanceCell.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/17/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

@objc protocol RadiusCellDelegate {
    optional func radiusCell(radiusCell: RadiusCell, valueUpdated: Bool)
}

class RadiusCell: UITableViewCell {
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    @IBOutlet weak var radiusLabel: UILabel!
    
    weak var delegate: RadiusCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func switchValueChanged() {
        println("change")
        delegate?.radiusCell?(self, valueUpdated: onSwitch.on)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}