//
//  CompareSelectViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/9/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class CompareSelectViewController: UIViewController {
    
    // MARK: - Properties
    
    let reuseIdentifier = "selectFavoriteCell"
    
    var vehicles: [String] = []
    var trims: [String] = []
    
    var selectedVehicleId: String!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBActions
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // load favorites from Core Data!
        vehicles = ["2018 Toyota Prius", "2018 Lamborghini Aventador"]
        trims = ["Five 4dr Hatchback (1.8L 4cyl gas/electric hybrid CVT)", "LP 700-4 2dr Coupe AWD (6.5L 12cyl 7AM)"]
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

extension CompareSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SelectTableViewCell
        
        cell.titleLabel.text = vehicles[indexPath.row]
        cell.trimLabel.text = trims[indexPath.row]
        
        return cell
    }
    
}

extension CompareSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // set the selected vehicle to pass to the VehicleTableViewController
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
