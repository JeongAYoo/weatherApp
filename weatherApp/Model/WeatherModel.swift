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
struct CurrentWeather: Codable {
    //let location: CLLocation
    let symbolName: String
    let temperature: Double    //.value로 접근
    //let lowTemperature: Double
    //let highTemperature: Double
    let condition: String
    let humidity: Double
    let windSpeed: Double
    let uvIndex: Int
    //let precipitationIntensity: ApparentTemperature
    //let isDaylight: Bool
    //let cloudCover: Double
    //let dewPoint: ApparentTemperature
    //let rainfallAmount: FallAmount
    //let snowfallAmount: FallAmount
    let date: String
    //let visibility: ApparentTemperature
    //let metadata: Metadata
    //let apparentTemperature, pressure: ApparentTemperature
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
