//
//  TableViewController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit

class CommentTableViewController: UITableViewController {
    var delegate: CommentTableControllerDelegate?
    var indexPath: Int?
    
    @IBOutlet weak var commentfield: UITextField!
    
    @IBAction func savecomment(_ sender: Any) {
        let text = commentfield.text
        delegate?.itemsaved(by: self, with: text!, at: indexPath)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Leave a comment"
    }
    
}
