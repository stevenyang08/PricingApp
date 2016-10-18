//
//  Extensions.swift
//  PricingApp
//
//  Created by Steven Yang on 10/17/16.
//  Copyright © 2016 Steven Yang. All rights reserved.
//

import Foundation

extension Int {
  var intToDouble: Double {
    return Double(self)
  }
  
  var intToString: String {
    return "\(self)"
  }
}

extension Double {
  var turnToPercent: Double {
    return self / 100.0
  }
  
  var doubleToInt: Int {
    return Int(self)
  }
  
  func roundTo(places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}

extension String {
  var stringToDouble: Double {
    if let price = Double(self) {
      return price
    } else {
      return 0.00
    }
  }
  
  var stringToInt: Int {
    if let units = Int(self) {
      return units
    } else {
      return 00
    }
  }
  
}
