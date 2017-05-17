//
//  RouteTableViewDelegate.swift
//  MapKit Starter
//
//  Created by Glen Jantz on 3/17/17.
//  Copyright © 2017 Pranjal Satija. All rights reserved.
//

import Foundation
import UIKit

protocol RouteTableViewDelegate: class {
    func routesaved(by controller: MakeRouteController, with run: runTrail)
}
