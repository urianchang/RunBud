//
//  ViewController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UILabel!
    
    @IBOutlet weak var motivateText: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        //: Check for current time and do the thingy-majig
        let current = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let currentHour = formatter.string(from: current as Date)
//        let currentHour = "12"
        if Int(currentHour)! >= 5 && Int(currentHour)! < 9 {
            welcomeText.text = "Good morning, Siri!"
            backgroundImage.image = UIImage(named: "road_morning")
        } else if Int(currentHour)! >= 10 && Int(currentHour)! < 16 {
            welcomeText.text = "Good afternoon, Siri!"
            welcomeText.textColor = UIColor.white
            weatherLabel.textColor = UIColor.red
            backgroundImage.image = UIImage(named: "road_afternoon")
        } else {
            welcomeText.text = "Good evening, Siri!"
            welcomeText.textColor = UIColor.white
            motivateText.textColor = UIColor.white
            weatherLabel.textColor = UIColor.red
            backgroundImage.image = UIImage(named: "road_night")
        }
        self.navigationController?.navigationBar.isHidden = true
        welcomeText.font = UIFont(name: "Papyrus", size: 25)
        motivateText.font = UIFont(name: "Papyrus", size: 25)
        weatherLabel.font = UIFont(name: "Papyrus", size: 25)
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
