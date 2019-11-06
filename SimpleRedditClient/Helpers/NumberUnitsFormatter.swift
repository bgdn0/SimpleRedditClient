//
//  Int+Formatting.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 06.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import Foundation

class NumberUnitsFormatter {
    private let numberFormatter: NumberFormatter
    
    static let shared = NumberUnitsFormatter()
    
    private init() {
        numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
    }
    
    func format(_ number: Int) -> String {
        let units = [(1.0, ""), (1000.0, "K"), (1_000_000.0, "M"), (1_000_000_000.0, "M")]
        
        let absValue = Double( abs(number) )
        var numberUnit = (1.0, "")
        for unit in units {
            if absValue < unit.0 { break }
            numberUnit = unit
        }
        
        let value = Double(number) / numberUnit.0
        numberFormatter.positiveSuffix = numberUnit.1
        numberFormatter.negativeSuffix = numberUnit.1
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
