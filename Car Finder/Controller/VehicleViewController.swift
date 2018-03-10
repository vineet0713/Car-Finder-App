//
//  VehicleViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/9/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "vehicleCell"
    let removeMessage = "Are you sure you want to remove this vehicle from your favorites list?"
    
    var titles: [String] = []
    var statistics: [String] = []
    
    var vehicleId: String!
    var isFavorite: Bool!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var modifyFavoriteButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func modifyFavorite(_ sender: Any) {
        if isFavorite {
            removeFavorite()
        } else {
            addFavorite()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Statistics"
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            
            // get the data!
            self.titles = ["Engine Position:", "Cylinders:", "Valves Per Cylinder:", "Type:", "Displacement (L):", "Horsepower:", "Torque (Lb-Ft):", "Fuel:", "Capacity (gal):", "Drive:", "Transmission:", "Weight (Lb):"]
            self.statistics = ["Front", "4", "4", "Inline", "1.8", "132", "null", "Regular Unleaded", "12", "Front Wheel Drive", "Automatic", "3042"]
            
            // use Core Data
            self.isFavorite = false
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.updateFavoriteButtonText()
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func addFavorite() {
        // save this to Core Data!
        isFavorite = true
        updateFavoriteButtonText()
    }
    
    func removeFavorite() {
        let alert = UIAlertController(title: "Confirm Remove", message: removeMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            // remove the favorite from Core Data
            self.isFavorite = false
            self.updateFavoriteButtonText()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateFavoriteButtonText() {
        if isFavorite {
            modifyFavoriteButton.setTitle("Remove Favorite", for: .normal)
        } else {
            modifyFavoriteButton.setTitle("Add Favorite", for: .normal)
        }
    }
    
}

extension VehicleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VehicleTableViewCell
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.statisticLabel.text = statistics[indexPath.row]
        
        return cell
    }
    
}
