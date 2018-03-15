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
    var selectedMakeID: String!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
        
        loadData()
    }
    
    // MARK: - Helper Functions
    
    @objc func loadData() {
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            // To show the activity indicator, even when connection speed is fast!
            // sleep(1)
            
            CarQueryClient.sharedInstance().getAllMakes(completionHandler: { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.tableView.separatorStyle = .singleLine
                        self.tableView.reloadData()
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
        return SharedData.sharedInstance().makes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MakeTableViewCell
        let make = SharedData.sharedInstance().makes[indexPath.row]
        
        cell.titleLabel.text = make.name
        cell.countryLabel.text = make.country
        if make.isCommon {
            cell.commonalityImage.image = UIImage(named: "common")
        } else {
            cell.commonalityImage.image = UIImage(named: "notcommon")
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let make = SharedData.sharedInstance().makes[indexPath.row]
        
        // set the selected make information to pass to the ModelsTableViewController
        selectedMake = make.name
        selectedMakeID = make.ID
        
        performSegue(withIdentifier: "makeToModelSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ModelsTableViewController {
            SharedData.sharedInstance().models.removeAll()
            destinationVC.make = selectedMake
            destinationVC.makeID = selectedMakeID
        }
    }
    
}
