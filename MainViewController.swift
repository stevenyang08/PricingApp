//
//  MainViewController.swift
//  PricingApp
//
//  Created by Steven Yang on 10/17/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var originalPriceTextField: UITextField!
  
  @IBOutlet weak var numberOfUnitsTextField: UITextField!

  @IBOutlet weak var markUpPercentLabel: UILabel!
  
  @IBOutlet weak var markUpSlider: UISlider!
  
  @IBOutlet weak var taxTextField: UITextField!
  
  @IBOutlet weak var originalCostPerUnitLabel: UILabel!
  
  @IBOutlet weak var costPerUnitLabel: UILabel!
  
  @IBOutlet weak var totalSalesRevenueLabel: UILabel!
  
  @IBOutlet weak var profitPerUnitLabel: UILabel!
  
  @IBOutlet weak var taxDeductionsLabel: UILabel!
  
  @IBOutlet weak var totalProfitLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround()
    let currentSliderValue = Int(markUpSlider.value)
    markUpPercentLabel.text = "\(currentSliderValue)%"
  }
  
  func updateLabels() {
    
    if originalPriceTextField.text != "" {
      
      if !(originalPriceTextField.text?.contains("."))! {
        
        originalPriceTextField.text?.append(".00")
      }
    }

    
    
    let currentSliderValue = Int(markUpSlider.value)
    markUpPercentLabel.text = "\(currentSliderValue)%"
    
    if let price = originalPriceTextField.text {
      
      if let units = numberOfUnitsTextField.text {
        
        
        if let tax = taxTextField.text {
          
          let calculator = Calculator(originalPrice: price,
                                      numberOfUnits: units,
                                      markUpPercent: currentSliderValue.intToString,
                                      taxRate: tax)
          
          originalCostPerUnitLabel.text = calculator.originalPricePerUnit
          costPerUnitLabel.text = calculator.markUpPricePerUnit
          totalSalesRevenueLabel.text = calculator.totalSalesRevenue
          profitPerUnitLabel.text = calculator.profitPerUnit
          taxDeductionsLabel.text = calculator.taxDeduction
          totalProfitLabel.text = calculator.totalProfit
          
        }
      }
    }

  }

  @IBAction func sliderMoved(_ sender: AnyObject) {
    
    updateLabels()
  }
  
}

extension MainViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    updateLabels()
    self.view.endEditing(true)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    updateLabels()
  }
  
}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}
