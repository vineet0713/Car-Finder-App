//
//  FavoritesTableViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "favoriteCell"
    
    var vehicles: [String] = []
    var trims: [String] = []
    
    var selectedVehicleId: String!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // load favorites from Core Data!
        vehicles = ["2018 Toyota Prius", "2018 Lamborghini Aventador"]
        trims = ["Five 4dr Hatchback (1.8L 4cyl gas/electric hybrid CVT)", "LP 700-4 2dr Coupe AWD (6.5L 12cyl 7AM)"]
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehicles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.titleLabel.text = vehicles[indexPath.row]
        cell.trimLabel.text = trims[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected vehicle to pass to the VehicleTableViewController
        
        performSegue(withIdentifier: "favoriteToVehicleSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VehicleViewController {
            destinationVC.vehicleId = selectedVehicleId
        }
    }
    
}
