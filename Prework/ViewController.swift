//
//  ViewController.swift
//  Prework
//
//  Created by Asad Rizvi on 7/23/21.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var groupSizeStepper: UIStepper!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    var defaults = UserDefaults.standard
    var tipPercentages = [0.15, 0.18, 0.20]
    var bill = 0.0, tip = 0.0, total = 0.0, totalPerPerson = 0.0, groupSize = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets title in navigation bar
        self.title = "Tip Calculator"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update tip percentages and tip control from user defaults
        updateTipPercentages()
        
        // Set bill amount to be first responder
        billAmountTextField.becomeFirstResponder()
        
        // Set bill amount to previously saved amount
        loadCurrentBill()
        
        // Set dark/light mode
        let darkModeOn = defaults.bool(forKey: "darkModeOn")
        updateColorSettings(isDark: darkModeOn)
    }
    
    /*
     Update the tip amounts for the current tip, total bill, and amount per person.
     */
    @IBAction func updateBillAmount(_ sender: Any) {
        // Update total bill and tip amount
        updateTotalAndTip()
        
        // Update total amount per person
        updateTotalPerPerson()
    }
    
    /*
     Update the tip amounts for the current tip, total bill, and amount per person.
     */
    @IBAction func calculateTip(_ sender: Any) {
        // Update total bill and tip amount
        updateTotalAndTip()
        
        // Update total amount per person
        updateTotalPerPerson()
    }
    
    /*
     Update total and tip amount.
     */
    func updateTotalAndTip() {
        // Calculate total tip by multiplying tip * tipPercentage
        bill = Double(billAmountTextField.text!) ?? 0
        tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        total = bill + tip
        
        // Update tip and total amount label with formatting
        tipAmountLabel.text = formatAmount(amount: tip)
        totalLabel.text = formatAmount(amount: total)
    
        // Save current bill amount to user defaults
        saveCurrentBill()
    }
    
    /*
     Update the group size label according to the group size stepper.
     */
    @IBAction func updateGroupSize(_ sender: Any) {
        // Update group size label
        groupSizeLabel.text = String(format: "%.0f", 1 + groupSizeStepper.value)
        
        // Update total amount per person
        updateTotalPerPerson()
    }
    
    /*
     Update total amount per person and its label.
     */
    func updateTotalPerPerson() {
        // Calculate total tip amount per person
        groupSize = Double(groupSizeLabel.text!) ?? 0
        totalPerPerson = total / groupSize
        
        // Update total tip per person
        totalPerPersonLabel.text = formatAmount(amount: totalPerPerson)
    }
    
    /*
     Update tip percentages and tip control from user defaults.
     */
    func updateTipPercentages() {
        // Get tip percentages from user defaults
        let tipOnePercentage = defaults.double(forKey: "tipOnePercentage")
        let tipTwoPercentage = defaults.double(forKey: "tipTwoPercentage")
        let tipThreePercentage = defaults.double(forKey: "tipThreePercentage")
        let tipList = [tipOnePercentage, tipTwoPercentage, tipThreePercentage]
        
        // Set tip control display values
        for i in 0...2 {
            tipControl.setTitle(String(format: "%.0f", tipList[i]) + "%", forSegmentAt: i)
        }
        
        // Update tip percentages with those in user defaults
        tipPercentages[0] = tipOnePercentage / 100.0
        tipPercentages[1] = tipTwoPercentage / 100.0
        tipPercentages[2] = tipThreePercentage / 100.0
    }
    
    /*
     Return the formatted amount with currency symbols and number separators.
     */
    func formatAmount(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        
        // Add the current currency symbol
        numberFormatter.numberStyle = .currency
        // Add number separators
        numberFormatter.usesGroupingSeparator = true
        
        return numberFormatter.string(from: NSNumber.init(value: amount))!
    }
    
    /*
     Save current bill amount to user defaults.
     */
    func saveCurrentBill() {
        defaults.set(bill, forKey: "currentBillAmount")
        defaults.synchronize()
    }
    
    /*
     Set current bill amount from that previously saved in user defaults.
     */
    func loadCurrentBill() {
        billAmountTextField.text = defaults.string(forKey: "currentBillAmount")
    }
    
    /*
     Sets light/dark mode settings
     */
    func updateColorSettings(isDark: Bool) {
        if (isDark) {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
}
