//
//  ViewController.swift
//  CodePath Tips
//
//  Created by Michael Andrew Pujol on 8/10/15.
//  Copyright (c) 2015 Michael Pujol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var divisionUIView: UIView!
    @IBOutlet weak var headCountStepper: UIStepper!
    @IBOutlet weak var headCountLabel: UILabel!
    @IBOutlet weak var headCountTitleLabel: UILabel!


    var animationSwitch = false
    var tipPercentages = [0.18, 0.2, 0.22]

    func hideUI () {
        self.tipLabel.alpha = 0
        self.tipTitleLabel.alpha = 0
        self.totalLabel.alpha = 0
        self.totalTitleLabel.alpha = 0
        self.tipControl.alpha = 0
        self.divisionUIView.alpha = 0
        self.headCountTitleLabel.alpha = 0
        self.headCountLabel.alpha = 0
        self.headCountStepper.alpha = 0
    }

    func showUI () {
        self.tipLabel.alpha = 1
        self.tipTitleLabel.alpha = 1
        self.totalLabel.alpha = 1
        self.totalTitleLabel.alpha = 1
        self.tipControl.alpha = 1
        self.divisionUIView.alpha = 1
        self.headCountTitleLabel.alpha = 1
        self.headCountLabel.alpha = 1
        self.headCountStepper.alpha = 1
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //HIDE EVERYTHING!!!! Well.. almost everything.

        hideUI()

        //Call the keyboard
        self.billField.becomeFirstResponder()

        //Center the UITextView
        var centerOfTextField = self.billField.frame
        var wholeScreen = self.view.frame

        centerOfTextField.origin.y = wholeScreen.height/2

        self.billField.frame = centerOfTextField


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {

        //Animate Up & Fade In Code
        if billField.text.isEmpty == false && animationSwitch == false {

            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: { () -> Void in

                    var centerOfTextField = self.billField.frame
                    var halfOfTheScreen = self.view.frame

                    centerOfTextField.origin.y -= (halfOfTheScreen.height / 2.4 )

                    self.billField.frame = centerOfTextField

                    self.animationSwitch = true

                    self.showUI()

                }) { (YES) -> Void in
                    println("Success")
            }
            
        }
        //Animate Down & Fade Out
        if billField.text.isEmpty == true  && animationSwitch == true{

            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: { () -> Void in

                    var centerOfTextField = self.billField.frame
                    var wholeScreen = self.view.frame

                    centerOfTextField.origin.y = wholeScreen.height/2

                    self.billField.frame = centerOfTextField

                    self.animationSwitch = false

                    self.hideUI()

                }) { (YES) -> Void in
                    println("Success")
            }
        }

        //Compute for the tip

        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        var headCount = headCountStepper.value

        var billAmount = (billField.text as NSString).doubleValue;
        var tip = (billAmount * tipPercentage) / headCount
        var total = (billAmount + tip) / headCount

        headCountLabel.text = String(format: "%.0f",headCount)
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

