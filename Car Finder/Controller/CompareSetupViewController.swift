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
        performSegue(withIdentifier: "setupToSelectSegue", sender: self)
    }
    
    @IBAction func secondModify(_ sender: Any) {
        performSegue(withIdentifier: "setupToSelectSegue", sender: self)
    }
    
    @IBAction func compare(_ sender: Any) {
        performSegue(withIdentifier: "setupToCompareSegue", sender: self)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
