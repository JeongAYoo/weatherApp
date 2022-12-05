//
//  WeatherKitManager.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/05.
//

import CoreLocation
import WeatherKit

struct CurrentWeather {
    
    let temperature: Double
    let condition: String
    let symbolName: String

}

public class WeatherKitManager: ObservableObject {
    
    let service = WeatherService()
    let currentLocation = CLLocation(latitude: 37.7749, longitude: 122.4194)
    var currentWeather: CurrentWeather?
    
    func getWeather() async {
        
        do {
            let weather = try await service.weather(for: currentLocation)
            
            self.currentWeather = CurrentWeather(
                temperature: weather.currentWeather.temperature.value,
                condition: weather.currentWeather.condition.rawValue,
                symbolName: weather.currentWeather.symbolName
            )
            
            print(self.currentWeather!)
            
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

}


