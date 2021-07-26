//
//  SettingsViewController.swift
//  Prework
//
//  Created by Asad Rizvi on 7/23/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var lowTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var highTipLabel: UILabel!
    
    @IBOutlet weak var lowTipStepper: UIStepper!
    @IBOutlet weak var mediumTipStepper: UIStepper!
    @IBOutlet weak var highTipStepper: UIStepper!
        
    var defaults = UserDefaults.standard
    var tipPercentages = [15.0, 18.0, 20.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets title in navigation bar
        self.title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get tip percentages from user defaults
        let tipOnePercentage = defaults.double(forKey: "tipOnePercentage")
        let tipTwoPercentage = defaults.double(forKey: "tipTwoPercentage")
        let tipThreePercentage = defaults.double(forKey: "tipThreePercentage")
        
        // Update tip labels
        lowTipLabel.text = String(format: "%.0f%", tipOnePercentage) + "%"
        mediumTipLabel.text = String(format: "%.0f%", tipTwoPercentage) + "%"
        highTipLabel.text = String(format: "%.0f%", tipThreePercentage) + "%"
        
        // Update tip stepper values with those from user defaults
        lowTipStepper.value = tipOnePercentage == 0 ? tipPercentages[0] : tipOnePercentage
        mediumTipStepper.value = tipTwoPercentage == 0 ? tipPercentages[1] : tipTwoPercentage
        highTipStepper.value = tipThreePercentage == 0 ? tipPercentages[2] : tipThreePercentage
    }

    /*
     Update low tip label and save its percentage to user defaults.
     */
    @IBAction func updateLowTipPercentage(_ sender: Any) {
        let tipOnePercentage = lowTipStepper.value
        
        // Update tip label according to its stepper
        lowTipLabel.text = String(format: "%.0f", tipOnePercentage) + "%"
        
        // Save tip percentage to user defaults
        defaults.set(tipOnePercentage, forKey: "tipOnePercentage")
        defaults.synchronize()
    }
    
    /*
     Update medium tip label and save its percentage to user defaults.
     */
    @IBAction func updateMediumTipPercentage(_ sender: Any) {
        let tipTwoPercentage = mediumTipStepper.value
        
        // Update tip label according to its stepper
        mediumTipLabel.text = String(format: "%.0f", tipTwoPercentage) + "%"
        
        // Save tip percentage to user defaults
        defaults.set(tipTwoPercentage, forKey: "tipTwoPercentage")
        defaults.synchronize()
    }
    
    /*
     Update hight tip label and save its percentage to user defaults.
     */
    @IBAction func updateHighTipPercentage(_ sender: Any) {
        let tipThreePercentage = highTipStepper.value
        
        // Update tip label according to its stepper
        highTipLabel.text = String(format: "%.0f", highTipStepper.value) + "%"
        
        // Save tip percentage to user defaults
        defaults.set(tipThreePercentage, forKey: "tipThreePercentage")
        defaults.synchronize()
    }
    
}
