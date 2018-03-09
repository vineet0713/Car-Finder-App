//
//  ModelsTableViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class ModelsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    let reuseIdentifier = "modelCell"
    
    var models: [String] = []
    
    var make: String! {
        willSet(newMake) {
            // set the title to the specified make
            self.title = newMake
        }
    }
    var makeId: String! {
        didSet {
            if activityIndicator != nil {
                reload()
            }
        }
    }
    
    var selectedModel: String!
    
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
        print("models are reloading")
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            
            // get the data!
            self.models = ["Mercedes-Benz", "Rolls-Royce", "Spyker", "Willys-Overland", "Zenvo"]
            
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
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ModelTableViewCell
        
        cell.titleLabel.text = models[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected model to pass to the TrimTableViewController
        selectedModel = models[indexPath.row]
        
        performSegue(withIdentifier: "modelToTrimSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TrimsTableViewController {
            destinationVC.model = selectedModel
        }
    }
    
}
