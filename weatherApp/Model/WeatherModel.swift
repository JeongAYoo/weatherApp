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
    var locationString: String = "기본"
    var symbolName: String = ""
    var temperature: Double = 0.0    //.value로 접근
    var lowTemperature: Double = 0.0
    var highTemperature: Double = 0.0
    var condition: String = ""
    var humidity: Double = 0.0
    var windSpeed: Double = 0.0
    var uvIndex: Int = 0
    //let precipitationIntensity: ApparentTemperature
    //let isDaylight: Bool
    //let cloudCover: Double
    //let dewPoint: ApparentTemperature
    //let rainfallAmount: FallAmount
    //let snowfallAmount: FallAmount
    var date: String = ""
    //let visibility: ApparentTemperature
    //let metadata: Metadata
    //let apparentTemperature, pressure: ApparentTemperature
    
    init(location: CLLocation, symbolName: String, temperature: Double, lowTemperature: Double, highTemperature: Double, condition: String, humidity: Double, windSpeed: Double, uvIndex: Int, date: String) {
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
    
    func convertToAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") //korea
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: local) { (placemarks, error) in
            // 1
            if let error = error {
                print(error)
            }
            
            // 2
            guard let placemark = placemarks?.first else { return }
            print(placemark)
            // Geary & Powell, Geary & Powell, 299 Geary St, San Francisco, CA 94102, United States @ <+37.78735352,-122.40822700> +/- 100.00m, region CLCircularRegion (identifier:'<+37.78735636,-122.40822737> radius 70.65', center:<+37.78735636,-122.40822737>, radius:70.65m)
            
            // 3
            let streetName = placemark.thoroughfare ?? ""
            guard let city = placemark.locality else { return }
            //guard let state = placemark.administrativeArea else { return }
            
            // 4
            //print("\(streetName) \n \(city)")
            self.locationString = "\(streetName), \(city)"
        }
    }
}
// MARK: - HourlyWeather
struct HourlyWeather {
    var symbolName: String
    var temperature: Double
    var date: String  // 시간만 뽑아내서 수정
}
// MARK: - DailyWeather
struct DailyWeather {
    let symbolName: String
    let date: String
    let highTemperture: Double
    let lowTemperature: Double
}
// MARK: - ApparentTemperature
struct ApparentTemperature: Codable {
    let value: Double
    let unit: Unit
}

// MARK: - Unit
struct Unit: Codable {
    let converter: Converter
    let symbol: String
}

// MARK: - Converter
struct Converter: Codable {
    let constant, coefficient: Double
}

// MARK: - Metadata
struct Metadata: Codable {
    let expirationDate: Int
    let latitude, longitude: Double
    let date: Int
}

// MARK: - FallAmount
struct FallAmount: Codable {
    let pastSixHours, pastHour, pastTwentyFourHours: ApparentTemperature
}

// MARK: - UvIndex
//struct UvIndex: Codable {
//    let value: Int
//    let category: String
//}

// MARK: - Wind
//struct Wind: Codable {
//    let gust, speed: ApparentTemperature
//    let compassDirection: String
//    let direction: ApparentTemperature
//}
