//
//  ViewController.swift
//  Tip
//
//  Created by Lakshay Sharma on 9/29/16.
//  Copyright © 2016 Lakshay Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Objects in View
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tipAmount: UILabel!
    
    // Functional Variables
    var tip = 0
    var bill = 0.0
    var userTyping = false
    var dotNotPressed = true
    var decimalValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Updates Total Label Value
    func updateLabel() {
        let total: Double = ((Double(tip)/100.00) * bill) + bill // Calculates Total
        let roundedValue = round(total * 100) // Rounds Total Value
        totalLabel.text = "$" + String(roundedValue / 100) // Updates Total Label
        let tipValue = round(((Double(tip)/100.00) * bill) * 100)
        tipAmount.text = "$" + String(tipValue/100)
    }

    // Calculates The Tip Decimal Value To Multiply With Bill Value
    @IBAction func calculateTip(_ sender: UISlider) {
        tipLabel.text = String(format: "%\(".2")f", round(slider.value * 30)) + "%"
        tip = Int(round(slider.value * 30))
        updateLabel()     }
    
    // Updates Labels And Variable For Functionality
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
                let number = String(Int(bill)) + sender.currentTitle!
                bill = Double(number)!
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

    func presentRating() {
        let alert = UIAlertController(title: "Rate Us?", message: "We would appreciate your rating", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(rateAction)
        alert.addAction(cancelAction)
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
        billLabel.text = "$0.00"
        bill = 0
        userTyping = false
        dotNotPressed = true
        decimalValue = 0.0
        updateLabel()
    }
    
}

