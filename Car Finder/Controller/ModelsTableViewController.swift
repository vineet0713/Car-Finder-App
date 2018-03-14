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
    
    var make: String! {
        willSet(newMake) {
            // set the title to the specified make
            self.title = newMake
        }
    }
    var makeID: String! {
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
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            // To show the activity indicator, even when connection speed is fast!
            // sleep(1)
            
            CarQueryClient.sharedInstance().getModelsFor(makeID: self.makeID, completionHandler: { (success, error) in
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedData.sharedInstance().models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ModelTableViewCell
        let model = SharedData.sharedInstance().models[indexPath.row]
        
        cell.titleLabel.text = model
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = SharedData.sharedInstance().models[indexPath.row]
        
        // set the selected model to pass to the TrimTableViewController
        selectedModel = model
        
        performSegue(withIdentifier: "modelToTrimSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TrimsTableViewController {
            SharedData.sharedInstance().trims.removeAll()
            destinationVC.makeID = makeID
            destinationVC.model = selectedModel
        }
    }
    
}
