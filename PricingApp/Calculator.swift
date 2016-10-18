//
//  Calculator.swift
//  PricingApp
//
//  Created by Steven Yang on 10/17/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation

class Calculator {
  
  private var _originalPrice: String!
  private var _numberOfUnits: String!
  private var _markUpPercent: String!
  private var _taxRate: String!
  
  var originalPrice: String {
    
    if _originalPrice == nil {
      
      _originalPrice = "0"
    }
    
    return _originalPrice
  }
  
  var numberOfUnits: String {
    
    if _numberOfUnits == nil {
      
      _numberOfUnits = "0"
    }
    
    return _numberOfUnits
    
  }
  
  var markUpPercent: String {
    
    if _markUpPercent == nil {
      
      _markUpPercent = "0"
    }
    
    return _markUpPercent
  }
  
  var taxRate: String {
    
    if _taxRate == nil {
      
      _taxRate = "0"
    }
    
    return _taxRate
  }
  
  var originalPricePerUnit: String {
    
    let calculation: String = originalUnitPriceToString(originalPrice: originalPrice,
                                                        numberOfUnits: numberOfUnits)
    
    return calculation
  }
  
  var markUpPricePerUnit: String {
    
    let calculation: String = markUpUnitPriceToString(originalPrice: originalPrice,
                                                      numberOfUnits: numberOfUnits,
                                                      markUpPercent: markUpPercent)
    
    return calculation
  }
  
  var totalSalesRevenue: String {
    
    let calculation: String = totalSalesRevenueCalculation(originalPrice: originalPrice,
                                                numberOfUnits: numberOfUnits,
                                                markUpPercent: markUpPercent)
    
    return calculation
  }
  
  var profitPerUnit: String {
    
    let calculation: String = profitPerUnitCalculation(originalPrice: originalPrice,
                                                       numberOfUnits: numberOfUnits,
                                                       markUpPercent: markUpPercent,
                                                       taxPercent: taxRate)
    
    return calculation
  }
  
  var taxDeduction: String {
    
    let calculation: String = taxDeductionsCalculation(originalPrice: originalPrice,
                                                       numberOfUnits: numberOfUnits,
                                                       markUpPercent: markUpPercent,
                                                       taxPercent: taxRate)
    
    return calculation
  }
  
  var totalProfit: String {
    
    let calculation: String = totalProfitCalculation(originalPrice: originalPrice, numberOfUnits: numberOfUnits, markUpPercent: markUpPercent, taxPercent: taxRate)
    
    return calculation
  }

  init(originalPrice: String, numberOfUnits: String, markUpPercent: String, taxRate: String) {
    
    self._originalPrice = originalPrice
    self._numberOfUnits = numberOfUnits
    self._markUpPercent = markUpPercent
    self._taxRate = taxRate
    
  }
  
  
  //Calculate Original Pricing
  
  func originalUnitPriceToString(originalPrice: String, numberOfUnits: String) -> String {
    
    let calculate = originalUnitPrice(originalPrice: originalPrice.stringToDouble,
                                      numberOfUnits: numberOfUnits.stringToInt)
    
    return String(format: "$%.2f", calculate)
  }
  
  func originalUnitPrice(originalPrice: Double, numberOfUnits: Int) -> Double {
    
    return (originalPrice / numberOfUnits.intToDouble)
  }
  
  //Calculate MarkUp Unit Pricing
  
  func markUpUnitPriceToString(originalPrice: String, numberOfUnits: String, markUpPercent: String) -> String {
    
    let calculate = markUpUnitPrice(originalPrice: originalPrice.stringToDouble,
                                    numberOfUnits: numberOfUnits.stringToInt,
                                    markUpPercent: markUpPercent.stringToInt)
    
    return String(format: "$%.2f", calculate)
  }
  
  func markUpUnitPrice(originalPrice: Double, numberOfUnits: Int, markUpPercent: Int) -> Double {
    
    var calculatedPrice: Double
    
    func percent(markUp: Int) -> Double {
      
      let markUpPercent: Double = 1.0 - (markUp.intToDouble).turnToPercent
      if markUpPercent <= 0.0 {
        
        return 0.00
      } else {
        
        return markUpPercent
      }
    }
    
    calculatedPrice = (originalPrice / numberOfUnits.intToDouble) / percent(markUp: markUpPercent)
    
    return calculatedPrice
  }
  
  //Calculate Profit Per Unit
  
  func profitPerUnitCalculation(originalPrice: String, numberOfUnits: String, markUpPercent: String, taxPercent: String) -> String {
    
    let origUnitPrice: Double = originalUnitPrice(originalPrice: originalPrice.stringToDouble,
                                                  numberOfUnits: numberOfUnits.stringToInt)
    
    let markPrice: Double = markUpUnitPrice(originalPrice: originalPrice.stringToDouble,
                                            numberOfUnits: numberOfUnits.stringToInt,
                                            markUpPercent: markUpPercent.stringToInt)
    
    let totalRevenue: Double = markPrice - origUnitPrice
    var taxes: Double
    
    if let tax = Double(taxPercent) {
      
      if tax <= 0 || tax > 100 {
        
        taxes = 0
      } else {
        
        taxes = tax
      }
    } else {
      
      taxes = 0
    }
    
    let totalCalculation: Double = (totalRevenue - (totalRevenue * (taxes / 100)))
    
    return String(format: "$%.2f", totalCalculation)
  }
  
  //Calculate Total Sales Revenue
  
  func totalSalesRevenueCalculation(originalPrice: String, numberOfUnits: String, markUpPercent: String) -> String {
    
    let origUnitPrice: Double = originalUnitPrice(originalPrice: originalPrice.stringToDouble,
                                                  numberOfUnits: numberOfUnits.stringToInt)
    
    let markPrice: Double = markUpUnitPrice(originalPrice: originalPrice.stringToDouble,
                                            numberOfUnits: numberOfUnits.stringToInt,
                                            markUpPercent: markUpPercent.stringToInt)
    
    let totalSalesRevenue: Double = (markPrice - origUnitPrice) * numberOfUnits.stringToDouble
    
    return String(format: "$%.2f", totalSalesRevenue)
    
  }
  
  //Tax Deductions
  
  func taxDeductionsCalculation(originalPrice: String, numberOfUnits: String, markUpPercent: String, taxPercent: String) -> String {
    
    let origUnitPrice: Double = originalUnitPrice(originalPrice: originalPrice.stringToDouble,
                                                  numberOfUnits: numberOfUnits.stringToInt)
    
    let markPrice: Double = markUpUnitPrice(originalPrice: originalPrice.stringToDouble,
                                            numberOfUnits: numberOfUnits.stringToInt,
                                            markUpPercent: markUpPercent.stringToInt)
    
    let totalRevenue: Double = markPrice - origUnitPrice
    var taxes: Double
    
    if let tax = Double(taxPercent) {
      
      if tax <= 0 || tax > 100 {
        
        taxes = 0
      } else {
        
        taxes = tax
      }
    } else {
      
      taxes = 0
    }
    
    let totalCalculation: Double = totalRevenue * (taxes / 100)
    
    return String(format: "$%.2f", totalCalculation)
  }
  
  
  //Calculate Total Profit
  
  func totalProfitCalculation(originalPrice: String, numberOfUnits: String, markUpPercent: String, taxPercent: String) -> String {
    
    let origUnitPrice: Double = originalUnitPrice(originalPrice: originalPrice.stringToDouble,
                                                  numberOfUnits: numberOfUnits.stringToInt)
    
    let markPrice: Double = markUpUnitPrice(originalPrice: originalPrice.stringToDouble,
                                            numberOfUnits: numberOfUnits.stringToInt,
                                            markUpPercent: markUpPercent.stringToInt)
    
    let totalRevenue: Double = markPrice - origUnitPrice
    var taxes: Double
    
    if let tax = Double(taxPercent) {
      
      if tax <= 0 || tax > 100 {
        
        taxes = 0
      } else {
        
        taxes = tax
      }
    } else {
      
      taxes = 0
    }
    
    let totalCalculation: Double = (totalRevenue - (totalRevenue * (taxes / 100))) * numberOfUnits.stringToDouble
    
    return String(format: "$%.2f", totalCalculation)
  }
  
}




