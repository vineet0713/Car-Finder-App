//
//  CompareTableViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class CompareTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "compareCell"
    
    var firstVehicleID: String!
    var secondVehicleID: String!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comparison"
        
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
            // To show the activity indicator, even when connection speed is fast!
            // sleep(1)
            
            var firstLoadSucceeded = true
            
            CarQueryClient.sharedInstance().getModelFor(modelID: self.firstVehicleID, vehicleToSave: "firstComparison", completionHandler: { (success, error) in
                if success == false {
                    firstLoadSucceeded = false
                    DispatchQueue.main.async {
                        self.showAlert(title: "Load Failed", message: error!)
                    }
                }
            })
            
            CarQueryClient.sharedInstance().getModelFor(modelID: self.secondVehicleID, vehicleToSave: "secondComparison", completionHandler: { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        if firstLoadSucceeded {
                            self.tableView.separatorStyle = .singleLine
                            self.tableView.reloadData()
                        }
                    } else {
                        self.showAlert(title: "Load Failed", message: error!)
                    }
                    self.activityIndicator.stopAnimating()
                }
            })
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let vehicle = SharedData.sharedInstance().firstComparisonVehicle {
            return vehicle.titles.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CompareTableViewCell
        let title = SharedData.sharedInstance().firstComparisonVehicle!.titles[indexPath.row] + ":"
        let firstStatistic = SharedData.sharedInstance().firstComparisonVehicle!.statistics[indexPath.row]
        let secondStatistic = SharedData.sharedInstance().secondComparisonVehicle!.statistics[indexPath.row]
        
        cell.titleLabel.text = title
        cell.firstStatisticLabel.text = firstStatistic
        cell.secondStatisticLabel.text = secondStatistic
        
        return cell
    }
    
}
