//
//  ViewController.swift
//  Tip
//
//  Created by Lakshay Sharma on 9/29/16.
//  Copyright © 2016 Lakshay Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var tip = 0
    var bill = 0
    var userTyping = false
    var dotNotPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func updateLabel() {
        let total: Double = ((Double(tip)/100.00) * Double(bill)) + Double(bill)
        totalLabel.text = String(total)
    }

    @IBAction func calculateTip(_ sender: UISlider) {
        tipLabel.text = String(format: "%\(".2")f", round(slider.value * 30)) + "%"
        tip = Int(slider.value * 30)
        updateLabel()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if userTyping {
            let currentText = billLabel.text
            billLabel.text = currentText! + sender.currentTitle!
            let number = String(bill) + sender.currentTitle!
            bill = Int(number)!
        } else {
            billLabel.text = "$" + sender.currentTitle!
            bill = Int(sender.currentTitle!)!
        }
        userTyping = true
        updateLabel()
    }

    @IBAction func dotPressed(_ sender: UIButton) {
        if dotNotPressed && userTyping {
            let currentText = billLabel.text
            billLabel.text = currentText! + "."
        }
    }

    @IBAction func clearBill(_ sender: UIButton) {
        billLabel.text = "$0.00"
        bill = 0
        userTyping = false
        updateLabel()
    }
    
}

