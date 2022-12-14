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
    let humidity: Double
    let symbolName: String

}

public class WeatherKitManager: ObservableObject {
    
    let service = WeatherService()
    var currentLocation = CLLocation(latitude: 37.7749, longitude: 122.4194)
    var currentWeather: CurrentWeather?
    
    func getWeather() async {
        
        do {
            let weather = try await service.weather(for: currentLocation)
            
            print("⭐️현재 위치: \(currentLocation)")
            
            self.currentWeather = CurrentWeather(
                temperature: weather.currentWeather.temperature.value,
                condition: weather.currentWeather.condition.rawValue,
                humidity: weather.currentWeather.humidity,
                symbolName: weather.currentWeather.symbolName
            )
            
            //테스트
            print("\n\n\n\n\n\n\n")
            print(weather.currentWeather.self)
            
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

}


