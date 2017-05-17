//
//  run_class.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit

class runTrail {
    var name : String
    var start: (Float, Float)
    var end: (Float, Float)
    var rating: Float
    var comments: [String]
    
    init(name: String, start: (Float, Float), end: (Float, Float), rating: Float, comments: [String]) {
        self.name = name
        self.start = start
        self.end = end
        self.rating = rating
        self.comments = comments
    }
}
