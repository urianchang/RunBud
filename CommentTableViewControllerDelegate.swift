//
//  CommentTableViewControllerDelegate.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit

protocol CommentTableControllerDelegate: class {
    func itemsaved(by controller: CommentTableViewController, with text: String, at indexPath: Int?)
    func cancel(by controller: CommentTableViewController)
}

