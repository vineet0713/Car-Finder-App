//
//  VehicleViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/9/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit
import CoreData

class VehicleViewController: UIViewController {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView!
    
    let reuseIdentifier = "vehicleCell"
    let removeMessage = "Are you sure you want to remove this vehicle from your favorites list?"
    
    var modelID: String!
    var favorite: Favorite?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var modifyFavoriteButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func modifyFavorite(_ sender: Any) {
        if favorite != nil {
            removeFavorite()
        } else {
            addFavorite()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Statistics"
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        tableView.backgroundView = activityIndicator
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        modifyFavoriteButton.setTitle("", for: .normal)
        
        DispatchQueue.global(qos: .userInitiated).async {
            // To show the activity indicator, even when connection speed is fast!
            // sleep(1)
            
            CarQueryClient.sharedInstance().getModelFor(modelID: self.modelID, completionHandler: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.separatorStyle = .singleLine
                        self.tableView.reloadData()
                    }
                } else {
                    self.showAlert(title: "Load Failed", message: error!)
                }
            })
            
            self.makeFetchRequest()
            
            DispatchQueue.main.async {
                self.updateFavoriteButtonText()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func makeFetchRequest() {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        // order doesn't matter, so no need to use NSSortDescriptors
        fetchRequest.sortDescriptors = []
        
        guard let listOfFavorites = try? DataController.sharedInstance().viewContext.fetch(fetchRequest) else {
            showAlert(title: "Unable to Load Favorites", message: "The fetch could not be performed.")
            return
        }
        
        for favoriteItem in listOfFavorites {
            if favoriteItem.modelID == modelID {
                self.favorite = favoriteItem
                return
            }
        }
        // if there isn't a return from the loop, then this vehicle is not a favorite!
        favorite = nil
    }
    
    func addFavorite() {
        let vehicle = SharedData.sharedInstance().displayVehicle
        
        /*
        DataController.sharedInstance().backgroundContext.perform {
            // should not access any UI elements, since UIKit is NOT thread-safe!
            
            // initializes the new Photo
            self.favorite = Favorite(context: DataController.sharedInstance().backgroundContext)
            self.favorite!.modelID = self.modelID
            self.favorite!.modelTitle = vehicle!.title
            self.favorite!.modelTrim = vehicle!.trim
            
            // tries to save the Photo to Core Data
            guard DataController.sharedInstance().saveBackgroundContext() else {
                self.showAlert(title: "Save Failed", message: "Could not save the Photo to Core Data.")
                return
            }
        }
        */
        
        // initializes the new Photo
        self.favorite = Favorite(context: DataController.sharedInstance().viewContext)
        self.favorite!.modelID = self.modelID
        self.favorite!.modelTitle = vehicle!.title
        if vehicle!.trim == "" {
            self.favorite!.modelTrim = "[trim unavailable]"
        } else {
            self.favorite!.modelTrim = vehicle!.trim
        }
        
        // tries to save the Photo to Core Data
        guard DataController.sharedInstance().saveViewContext() else {
            self.showAlert(title: "Save Failed", message: "Could not save the Photo to Core Data.")
            return
        }
        
        updateFavoriteButtonText()
    }
    
    func removeFavorite() {
        let alert = UIAlertController(title: "Confirm Remove", message: removeMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            DataController.sharedInstance().viewContext.delete(self.favorite!)
            self.favorite = nil
            guard DataController.sharedInstance().saveViewContext() else {
                self.showAlert(title: "Save Failed", message: "Unable to remove the favorite model.")
                return
            }
            self.updateFavoriteButtonText()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateFavoriteButtonText() {
        if favorite != nil {
            modifyFavoriteButton.setTitle("Remove Favorite", for: .normal)
        } else {
            modifyFavoriteButton.setTitle("Add Favorite", for: .normal)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension VehicleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let vehicle = SharedData.sharedInstance().displayVehicle {
            return vehicle.titles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VehicleTableViewCell
        let title = SharedData.sharedInstance().displayVehicle!.titles[indexPath.row] + ":"
        let statistic = SharedData.sharedInstance().displayVehicle!.statistics[indexPath.row]
        
        cell.titleLabel.text = title
        cell.statisticLabel.text = statistic
        
        return cell
    }
    
}
