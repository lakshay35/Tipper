//
//  ViewController.swift
//  Tip
//
//  Created by Lakshay Sharma on 9/29/16.
//  Copyright © 2016 Lakshay Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    /* 
     Objects declaration
    */
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tipAmount: UILabel!
    
    /* 
     Functional variable declaration
     */
    var tip = 0
    var bill = 0.0
    var userTyping = false
    var dotNotPressed = true
    var decimalValue = 0.0
    var keysDisabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
    Function to update total label value
     */
    func updateLabel() {
        let total = ((Double(tip)/100.00) * bill) + bill                    // Calculates Total
        let roundedValue = round(total * 100)                               // Rounds Total Value
        totalLabel.text = "$" + String(roundedValue / 100)                  // Updates Total Label
        let tipValue = round(((Double(tip)/100.00) * bill) * 100)
        tipAmount.text = "$" + String(tipValue/100)
    }

    /*
    Calculates the tip decimal value to multiply with bill value
     */
    @IBAction func calculateTip(_ sender: UISlider) {
        tipLabel.text = String(format: "%\(".2")f", round(slider.value * 30)) + "%"
        tip = Int(round(slider.value * 30))
        updateLabel()
    }
    
    /* 
    Updates labels and variable For Functionality
     */
    @IBAction func numberPressed(_ sender: UIButton) {
        // If User Has Typed Atleast Once
        if userTyping {
            let currentText = billLabel.text
            billLabel.text = currentText! + sender.currentTitle!
           
            if !dotNotPressed { // Starts Counting Decimal Values
                let index = billLabel.text?.characters.index(of: ".") // Gets Index Of The Starting Point Of Decimal Value
                let number = billLabel.text?.substring(from: index!)
                bill -= decimalValue
                decimalValue = Double(number!)!
                bill += decimalValue
            }
            else {
                if bill < Double(Int.max) {
                    let number = String(Int(bill)) + sender.currentTitle!
                    bill = Double(number)!
                } else {
                    overusageAlert()
                    systemResetSettings()
                }
            }
        }
        else { // Gets Executed If User Has Not Typed Even Once
            billLabel.text = "$" + sender.currentTitle!
            bill = Double(sender.currentTitle!)!
        }
        
        // User Has Typed Atleast Once
        userTyping = true
        // Live Updating Of Total Label
        updateLabel()
    }
    
    // Issues overusage
    func overusageAlert() {
        let alert = UIAlertController(title: "Warning: Too Much Power!", message: "You are attempting to use too much power. Settings are being reset", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Starts Counting Decimal Values
    @IBAction func dotPressed(_ sender: UIButton) {
        if dotNotPressed && userTyping {
            let currentText = billLabel.text
            billLabel.text = currentText! + "."
            dotNotPressed = false
        }
    }

    // Resets Labels and Functional Variables
    @IBAction func clearBill(_ sender: UIButton) {
        systemResetSettings()
    }
    
    func systemResetSettings() { // Resets System variables
        billLabel.text = "$"
        bill = 0
        userTyping = false
        dotNotPressed = true
        decimalValue = 0.0
        updateLabel()
    }
}

