//
//  TrimsTableViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/8/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class TrimsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "trimCell"
    
    var trims: [String] = []
    var years: [String] = []
    
    var model: String! {
        willSet(newModel) {
            // set the title to the specified make
            self.title = newModel
            if activityIndicator != nil {
                reload()
            }
        }
    }
    
    var selectedVehicleId: String!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
        
        reload()
    }
    
    // MARK: - Helper Functions
    
    func reload() {
        print("trims are reloading")
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            
            // get the data!
            self.trims = ["LP 700-4 2dr Coupe AWD (6.5L 12cyl 7AM)", "LP 700-4 Roadster 2dr Convertible AWD (6.5L 12cyl 7AM)"]
            self.years = ["2018", "2018"]
            
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
        return trims.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrimTableViewCell
        
        cell.titleLabel.text = trims[indexPath.row]
        cell.yearLabel.text = years[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected vehicle to pass to the VehicleTableViewController
        
        performSegue(withIdentifier: "trimToVehicleSegue", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VehicleTableViewController {
            destinationVC.vehicleId = selectedVehicleId
        }
    }
    
}
