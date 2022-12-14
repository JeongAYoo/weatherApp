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

// MARK: - CurrentWeather
struct CurrentWeather2: Codable {
    let rainfallAmount: FallAmount
    let condition: String
    let humidity: Double
    let precipitationIntensity, temperature: ApparentTemperature
    let isDaylight: Bool
    let cloudCover: Double
    let symbolName, pressureTrend: String
    let dewPoint: ApparentTemperature
    let uvIndex: UvIndex
    let snowfallAmount: FallAmount
    let date: Int
    let visibility: ApparentTemperature
    let wind: Wind
    let metadata: Metadata
    let apparentTemperature, pressure: ApparentTemperature
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
struct UvIndex: Codable {
    let value: Int
    let category: String
}

// MARK: - Wind
struct Wind: Codable {
    let gust, speed: ApparentTemperature
    let compassDirection: String
    let direction: ApparentTemperature
}
