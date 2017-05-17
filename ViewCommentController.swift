//
//  ViewCommentController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit

class ViewCommentController: UITableViewController, CommentTableControllerDelegate {
    
    @IBOutlet var commenttable: UITableView!
    var runName: String?
    var comments: [String]?
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let runName = runName {
            self.title = "\(runName)"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (comments?.count)! == 0 {
            return 1
        } else {
            return (comments?.count)!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commenttable.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        if (comments?.count)! == 0 {
            cell.textLabel?.text = "No comments yet."
        } else {
            cell.textLabel?.text = comments?[indexPath.row]
        }
        return cell
    }
    
    @IBAction func backtoruns(_ sender: Any) {
        performSegue(withIdentifier: "unwindruns", sender: self)
    }
    
    func itemsaved(by controller: CommentTableViewController, with text: String, at indexPath: NSIndexPath?){
        print("saved")
    }
    
    func cancel(by controller: CommentTableViewController){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addcommentsegue" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.topViewController as! CommentTableViewController
            destination.delegate = self
            destination.indexPath = indexPath
        }
    }
    
    func itemsaved(by controller: CommentTableViewController, with text: String, at indexPath: Int?) {
        comments!.append(text)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
