//
//  CompareSelectViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/9/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit
import CoreData

class CompareSelectViewController: UIViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "selectFavoriteCell"
    
    var favorites: [Favorite] = []
    
    var selectedFavorite: Favorite!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavoritesLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeFetchRequest()
        
        updateTableAndLabel()
        
        if (favorites.count > 0) {
            tableView.reloadData()
        }
    }
    
    // MARK: - Helper Functions
    
    func makeFetchRequest() {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        // order doesn't matter, so no need to use NSSortDescriptors
        fetchRequest.sortDescriptors = []
        
        if let result = try? DataController.sharedInstance().viewContext.fetch(fetchRequest) {
            favorites = result
        } else {
            showAlert(title: "Unable to Load Favorites", message: "The fetch could not be performed.")
        }
    }
    
    func updateTableAndLabel() {
        tableView.isHidden = (favorites.count == 0)
        noFavoritesLabel.isHidden = (favorites.count > 0)
    }
    
}

// MARK: - Table View Data Source

extension CompareSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectTableViewCell
        let favorite = favorites[indexPath.row]
        
        cell.titleLabel.text = favorite.modelTitle
        cell.trimLabel.text = favorite.modelTrim
        
        return cell
    }
    
}

// MARK: - Table View Delegate

extension CompareSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected Favorite to pass to the VehicleTableViewController
        selectedFavorite = favorites[indexPath.row]
        
        performSegue(withIdentifier: "unwindToCompareSetup", sender: self)
    }
    
}
