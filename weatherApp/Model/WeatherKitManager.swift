//
//  WeatherKitManager.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/05.
//

import CoreLocation
import WeatherKit

public class WeatherKitManager: ObservableObject {
    
    let service = WeatherService()
    //서울로 테스트
    var currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
    
    var currentWeather: CurrentWeather?
    var hourlyWeahter: Forecast<HourWeather>?
    var dailyWeather: Forecast<DayWeather>?
    
    func fetchWeather() async {
        
        currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
        
        do {
            let (current, hourly, daily) = try await service.weather(for: currentLocation, including: .current, .hourly, .daily)
            
            print("⭐️현재 위치: \(currentLocation)")
            
            self.currentWeather = CurrentWeather(
                //location: weather.currentWeather.metadata.location,
                symbolName: current.symbolName,
                temperature: current.temperature.value,
                condition: current.condition.rawValue,
                humidity: current.humidity,
                windSpeed: current.wind.speed.value,
                uvIndex: current.uvIndex.value,
                date: current.date.formatted()
            )
            
            self.hourlyWeahter = hourly
            self.dailyWeather = daily
            
            
            //테스트
            print("\n\n\n\n\n\n\n")
            print(hourly[0].date)
            print(hourly[9].date)
            //print(daily[0])
            print(hourly[0].date.formatted(.dateTime.hour()))
            print(hourly[9].date.formatted(.dateTime.hour()))

            //print(self.currentWeather!)
            
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func getCurrentWeather() -> CurrentWeather? {
        return currentWeather
    }
    
    func getHourlyWeather() -> Forecast<HourWeather>? {
        return hourlyWeahter
    }
    
    func getDailyWeather() -> Forecast<DayWeather>? {
        return dailyWeather
    }

}


