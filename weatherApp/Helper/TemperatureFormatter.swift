//
//  TemperatureFormatter.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/02/08.
//

import Foundation

class TemperatureFormatter {
    let formatter = MeasurementFormatter()
    
    init() {
        formatter.locale = Locale.init(identifier: "ko_KR")
        formatter.numberFormatter.roundingMode = .up
        formatter.numberFormatter.maximumFractionDigits = 0
    }
}

