//
//  RunTableViewController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

var glen = runTrail(name: "Glen's run", start: (37.3753997, -121.9101584), end: (37.292846, -121.99183399999998), rating: 4.5, comments: ["Ran with 5 guys to get 5 guys."])
var urian = runTrail(name: "Urian's run", start: (37.3753997, -121.9101584), end: (37.3868858, -121.8835651), rating: 2.5, comments: [])
var carolyn = runTrail(name: "Carolyn's run", start: (37.3753997, -121.9101584), end: (37.370577, -121.9090132), rating: 5.0, comments: ["BEST RUN EVAR", "I run this route every day!"])
var ali = runTrail(name: "Ali's run", start: (37.3753997, -121.9101584), end: (37.3814862, -121.95835310000001), rating: 4.0, comments: ["WHOO"])
var nikki = runTrail(name: "Nikki's run", start: (37.3753997, -121.9101584), end: (37.3875237, -121.9636595), rating: 4.0, comments: ["Awesome run", "Really good sights"])
var han = runTrail(name: "Kessel Run", start: (37.3753997, -121.9101584), end: (37.3639472, -121.92893750000002), rating: 2.0, comments: ["Han shot first", "12 parsecs?!"])

var runs = [carolyn, glen, nikki, ali, urian, han]


class RunTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RouteTableViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.reloadData()
        tableview.delegate = self
        tableview.dataSource = self
        self.title = "Search results"
        self.navigationController?.navigationBar.isHidden = false
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RunTableViewController.addTapped))
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem], animated: true)
    }
    
    func addTapped (sender:UIButton) {
        performSegue(withIdentifier: "createRouteSegue", sender: self)
    }
    
    @IBAction func clickcomment(_ sender: UIButton) {
        performSegue(withIdentifier: "commentsegue", sender: sender)
    }
    
    @IBAction func unwindtoruns(_ segue: UIStoryboardSegue){}
    @IBAction func unwindfromroute(_ segue: UIStoryboardSegue){}
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "mapsegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Cell1
        cell.namelabel?.text = runs[indexPath.row].name
        cell.starlabel?.text = String(runs[indexPath.row].rating)+"/5"
        cell.button.tag = indexPath.row
        return cell
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){
    }
    
    func routesaved(by controller: MakeRouteController, with run: runTrail) {
        runs.append(run)
        print("run saved")
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapsegue" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.topViewController as! MapViewController
            let indexPath = sender as! NSIndexPath
            destination.source = runs[indexPath.row].start
            destination.destination = runs[indexPath.row].end
        } else if segue.identifier == "commentsegue" {
            let navigationController2 = segue.destination as! UINavigationController
            let destination = navigationController2.topViewController as! ViewCommentController
            if let button = sender as? UIButton {
                destination.comments = runs[button.tag].comments
                destination.runName = runs[button.tag].name
                destination.indexPath = button.tag
            }
        }
        else if segue.identifier == "createRouteSegue" {
                let navigationController = segue.destination as! UINavigationController
                let destination = navigationController.topViewController as! MakeRouteController
                print("creating route")
                destination.delegate = self
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

