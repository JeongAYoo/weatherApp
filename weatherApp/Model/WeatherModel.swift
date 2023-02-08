//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/15.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeather = try? newJSONDecoder().decode(CurrentWeather.self, from: jsonData)

import Foundation
import WeatherKit
import CoreLocation

// MARK: - CurrentWeather
class CurrentWeather {
    var location: CLLocation? = nil
    var locationString: String = ""
    var symbolName: String = ""
    var temperature: Measurement<UnitTemperature>
    var lowTemperature: Measurement<UnitTemperature>
    var highTemperature: Measurement<UnitTemperature>
    var condition: String = ""
    var humidity: Double = 0.0
    var windSpeed: Double = 0.0
    var uvIndex: Int = 0
    var date: String = ""
    
    init(location: CLLocation,symbolName: String, temperature: Measurement<UnitTemperature>, lowTemperature: Measurement<UnitTemperature>, highTemperature: Measurement<UnitTemperature>, condition: String, humidity: Double, windSpeed: Double, uvIndex: Int, date: String) {
        self.location = location
        self.symbolName = symbolName
        self.temperature = temperature
        self.lowTemperature = lowTemperature
        self.highTemperature = highTemperature
        self.condition = condition
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.uvIndex = uvIndex
        self.date = date
    }
}
// MARK: - HourlyWeather
struct HourlyWeather {
    var symbolName: String
    var temperature: Measurement<UnitTemperature>
    var date: String
}

// MARK: - DailyWeather
struct DailyWeather {
    let symbolName: String
    let date: String
    var highTemperture: Measurement<UnitTemperature>
    let lowTemperature: Measurement<UnitTemperature>
}

// MARK: - Metadata
struct Metadata: Codable {
    let expirationDate: Int
    let latitude, longitude: Double
    let date: Int
}
