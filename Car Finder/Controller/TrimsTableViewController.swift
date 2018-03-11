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
    
    var makeID: String!
    var model: String! {
        willSet(newModel) {
            // set the title to the specified make
            self.title = newModel
            if activityIndicator != nil {
                reload()
            }
        }
    }
    
    var selectedModelID: String!
    
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
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            // To show the activity indicator, even when connection speed is fast!
            // sleep(1)
            
            CarQueryClient.sharedInstance().getTrimsFor(makeID: self.makeID, modelName: self.model, completionHandler: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.separatorStyle = .singleLine
                        self.tableView.reloadData()
                    }
                } else {
                    self.showAlert(title: "Load Failed", message: error!)
                }
            })
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance().trims.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrimTableViewCell
        let trim = SharedData.sharedInstance().trims[indexPath.row]
        
        cell.titleLabel.text = trim.modelTrim
        cell.yearLabel.text = trim.modelYear
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trim = SharedData.sharedInstance().trims[indexPath.row]
        
        // set the selected vehicle to pass to the VehicleTableViewController
        selectedModelID = trim.modelID
        
        performSegue(withIdentifier: "trimToVehicleSegue", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? VehicleViewController {
            destinationVC.modelID = selectedModelID
        }
    }
    
}
