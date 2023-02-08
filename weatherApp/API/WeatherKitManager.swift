//
//  WeatherKitManager.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/05.
//

import CoreLocation
import WeatherKit

public class WeatherKitManager: ObservableObject {
    
    static let shared = WeatherKitManager()
    
    private init() {}
    
    let service = WeatherService()
    
    //서울로 테스트
    var currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
    
    var currentWeather: CurrentWeather?
    var hourlyWeather: [HourlyWeather] = []
    var dailyWeather: [DailyWeather] = []
    
    func fetchWeather(location: CLLocation, completion: @escaping (CurrentWeather?, [HourlyWeather]?, [DailyWeather]?) -> Void) async {
        
        hourlyWeather = []
        dailyWeather = []
        
        do {
            let (current, hourly, daily) = try await service.weather(for: location, including: .current, .hourly, .daily)
            
            // 현재 날씨 데이터 가져오기
            self.currentWeather = CurrentWeather(
                location: current.metadata.location,
                symbolName: current.symbolName,
                temperature: current.temperature,
                lowTemperature: daily[0].lowTemperature,
                highTemperature: daily[0].highTemperature,
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
                    let temp = HourlyWeather(symbolName: hourly[i].symbolName, temperature: hourly[i].temperature, date: hourly[i].date.formatted(.dateTime.hour()))
                    hourlyWeather.append(temp)
                }
            }
            
            // 일별 날씨 예측 데이터 가져오기
            for i in 0..<10 {
                let temp = DailyWeather(
                    symbolName: daily[i].symbolName,
                    date: daily[i].date.formatted(.dateTime.weekday(.wide).locale(Locale(identifier: "ko_KR"))),
                    highTemperture: daily[i].highTemperature,
                    lowTemperature: daily[i].lowTemperature
                )
                dailyWeather.append(temp)
            }
            
            completion(currentWeather, hourlyWeather, dailyWeather)
            
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}

