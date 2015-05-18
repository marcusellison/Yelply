//
//  Filters.swift
//  Yelp
//
//  Created by Marcus J. Ellison on 5/16/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

class Category: NSObject {
    let title = "Category"
    
    let categories = {
        return [
            ["name" : "African", "code": "african"],
            ["name" : "Brazilian", "code": "brazilian"],
            ["name" : "Burgers", "code": "burgers"],
            ["name" : "American, New", "code": "newamerican"]
        ]
        }
}

class Sort: NSObject {
    let title = "Sort"
    
    let categories = ["match", "distance", "rating"]
}

class Radius: NSObject {
    let title = "Radius"
    
    var radius = 0
}

class Deals: NSObject {
    let title = "Deals"
    
    var on = false
}
