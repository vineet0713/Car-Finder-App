//
//  MakesTableViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class MakesTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "makeCell"
    
    var selectedMake: String!
    var selectedMakeId: String!
    
    var makes: [String] = []
    var countries: [String] = []
    var commonalities: [Int] = []
    
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
    
    @objc func reload() {
        print("makes are reloading")
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            
            // get the data!
            self.makes = ["Mercedes-Benz", "Rolls-Royce", "Spyker", "Willys-Overland", "Zenvo"]
            self.countries = ["Germany", "UK", "Netherlands", "USA", "Denmark"]
            self.commonalities = [1, 1, 1, 1, 0]
            
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
        return makes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MakeTableViewCell
        
        cell.titleLabel.text = makes[indexPath.row]
        cell.countryLabel.text = countries[indexPath.row]
        if commonalities[indexPath.row] == 1 {
            cell.commonalityImage.image = UIImage(named: "common")
        } else {
            cell.commonalityImage.image = UIImage(named: "notcommon")
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected make information to pass to the ModelsTableViewController
        selectedMake = makes[indexPath.row]
        selectedMakeId = makes[indexPath.row]
        
        performSegue(withIdentifier: "makeToModelSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ModelsTableViewController {
            destinationVC.make = selectedMake
            destinationVC.makeId = selectedMakeId
        }
    }
    
}
