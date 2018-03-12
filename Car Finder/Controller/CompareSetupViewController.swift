//
//  CompareSetupViewController.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/5/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import UIKit

class CompareSetupViewController: UIViewController {
    
    // MARK: - Properties
    
    let firstDefaultTitle = "Vehicle 1"
    let secondDefaultTitle = "Vehicle 2"
    
    var firstModelID: String?
    var secondModelID: String?
    
    var firstIsModified: Bool!
    var invalidComparisonMessage: String?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstTrimLabel: UILabel!
    @IBOutlet weak var firstModifyButton: UIButton!
    
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondTrimLabel: UILabel!
    @IBOutlet weak var secondModifyButton: UIButton!
    
    @IBOutlet weak var compareButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func firstModify(_ sender: Any) {
        firstIsModified = true
        performSegue(withIdentifier: "setupToSelectSegue", sender: self)
    }
    
    @IBAction func secondModify(_ sender: Any) {
        firstIsModified = false
        performSegue(withIdentifier: "setupToSelectSegue", sender: self)
    }
    
    @IBAction func compare(_ sender: Any) {
        performSegue(withIdentifier: "setupToCompareSegue", sender: self)
    }
    
    // first create this function
    // then on storyboard, drag from the source VC (or CompareSelectVC in this case) to its own exit button
    // select this function
    // link: https://www.andrewcbancroft.com/2015/12/18/working-with-unwind-segues-programmatically-in-swift/
    @IBAction func unwindFromSelectFavorite(_ sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? CompareSelectViewController {
            if firstIsModified {
                // makes sure that the user's second selected car is different from the first!
                if secondModelID != nil && secondModelID! == sourceVC.selectedFavorite.modelID {
                    invalidComparisonMessage = "Please select a different car than the second."
                } else {
                    firstTitleLabel.text = sourceVC.selectedFavorite.modelTitle
                    firstTrimLabel.text = sourceVC.selectedFavorite.modelTrim
                    firstModelID = sourceVC.selectedFavorite.modelID
                }
            } else {
                // makes sure that the user's first selected car is different from the second!
                if firstModelID != nil && firstModelID! == sourceVC.selectedFavorite.modelID {
                    invalidComparisonMessage = "Please select a different car than the first."
                } else {
                    secondTitleLabel.text = sourceVC.selectedFavorite.modelTitle
                    secondTrimLabel.text = sourceVC.selectedFavorite.modelTrim
                    secondModelID = sourceVC.selectedFavorite.modelID
                }
            }
            updateButtonTexts()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstModelID = nil
        secondModelID = nil
        
        compareButton.isEnabled = false
        firstModifyButton.setTitle("Choose", for: .normal)
        secondModifyButton.setTitle("Choose", for: .normal)
        
        invalidComparisonMessage = nil
        
        firstTitleLabel.text = firstDefaultTitle
        secondTitleLabel.text = secondDefaultTitle
        firstTrimLabel.text = ""
        secondTrimLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let message = invalidComparisonMessage {
            showAlert(title: "Invalid Comparison", message: message)
            invalidComparisonMessage = nil
        }
    }
    
    // MARK: - Helper Functions
    
    func updateButtonTexts() {
        compareButton.isEnabled = (firstModelID != nil && secondModelID != nil)
        
        let firstModifyText = (firstModelID == nil) ? "Choose" : "Change"
        let secondModifyText = (secondModelID == nil) ? "Choose" : "Change"
        
        firstModifyButton.setTitle(firstModifyText, for: .normal)
        secondModifyButton.setTitle(secondModifyText, for: .normal)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CompareTableViewController {
            SharedData.sharedInstance().firstComparisonVehicle = nil
            SharedData.sharedInstance().secondComparisonVehicle = nil
            
            destinationVC.firstVehicleID = firstModelID
            destinationVC.secondVehicleID = secondModelID
        }
    }
    
}
