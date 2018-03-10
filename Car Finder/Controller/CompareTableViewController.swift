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
    
    var titles: [String] = []
    var firstStatistics: [String] = []
    var secondStatistics: [String] = []
    
    var firstVehicleId: String!
    var secondVehicleId: String!
    
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
            sleep(1)
            
            // get the data!
            self.titles = ["Engine Position:", "Cylinders:", "Valves Per Cylinder:", "Type:", "Displacement (L):", "Horsepower:", "Torque (Lb-Ft):", "Fuel:", "Capacity (gal):", "Drive:", "Transmission:", "Weight (Lb):"]
            self.firstStatistics = ["Front", "4", "4", "Inline", "1.8", "132", "null", "Regular Unleaded", "12", "Front Wheel Drive", "Automatic", "3042"]
            self.secondStatistics = ["Front", "4", "4", "Inline", "1.8", "132", "null", "Regular Unleaded", "12", "Front Wheel Drive", "Automatic", "3042"]
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CompareTableViewCell
        
        cell.titleLabel.text = titles[indexPath.row]
        cell.firstStatisticLabel.text = firstStatistics[indexPath.row]
        cell.secondStatisticLabel.text = secondStatistics[indexPath.row]
        
        return cell
    }
    
    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
