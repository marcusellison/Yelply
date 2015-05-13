//
//  BusinessCell.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/12/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImageView.layer.cornerRadius = 4
        thumbImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    var business: Business! {
        didSet {
            var reviewCount = Int(business.reviewCount!)
            
            thumbImageView.setImageWithURL(business.imageURL)
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            ratingImageView.setImageWithURL(business.ratingImageURL)
            addressLabel.text = business.address
            categoryLabel.text = business.categories
            ratingLabel.text = "\(reviewCount) reviews"
        }
    }
}
