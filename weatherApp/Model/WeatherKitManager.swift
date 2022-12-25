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
    var hourlyWeather: [HourlyWeather] = []
    var dailyWeather: [DailyWeather] = []
    
    func fetchWeather() async {
        
        currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
        
        do {
            let (current, hourly, daily) = try await service.weather(for: currentLocation, including: .current, .hourly, .daily)
            
            print("⭐️현재 위치: \(currentLocation)")
            // 현재 날씨 데이터 가져오기
            self.currentWeather = CurrentWeather(
                //location: weather.currentWeather.metadata.location,
                symbolName: current.symbolName,
                temperature: current.temperature.value,
                lowTemperature: daily[0].lowTemperature.value,
                highTemperature: daily[0].highTemperature.value,
                condition: current.condition.description,
                humidity: current.humidity,
                windSpeed: current.wind.speed.value,
                uvIndex: current.uvIndex.value,
                date: current.date.formatted()
            )
            // 시간별 날씨 예측 데이터 가져오기
            // 현재 시간 + 12시간 이후까지
            let firstHourIndex = hourly.firstIndex { element in
                element.date > .now
            }
            for i in firstHourIndex!..<firstHourIndex! + 12 {
                if hourly[i].date > .now {
                    let temp = HourlyWeather(symbolName: hourly[i].symbolName, temperature: hourly[i].temperature.value, date: hourly[i].date.formatted(.dateTime.hour()))
                    hourlyWeather.append(temp)
                }
            }
            // 일별 날씨 예측 데이터 가져오기
            for i in 0..<10 {
                let temp = DailyWeather(
                    symbolName: daily[i].symbolName,
                    date: daily[i].date.formatted(.dateTime.weekday(.wide).locale(Locale(identifier: "ko_KR"))),
                    highTemperture: daily[i].highTemperature.value,
                    lowTemperature: daily[i].lowTemperature.value
                )
                dailyWeather.append(temp)
            }            
            
            //테스트
            print("\n\n\n\n\n\n\n")
            print(hourlyWeather.count)
            print(daily.count)

        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func getCurrentWeather() -> CurrentWeather? {
        return currentWeather
    }
    
    func getHourlyWeather() -> [HourlyWeather]? {
        return hourlyWeather
    }
    
    func getDailyWeather() -> [DailyWeather]? {
        return dailyWeather
    }

}


