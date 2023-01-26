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
    
    func fetchWeather(location: CLLocation) async {
        
        //currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
        
        do {
            let (current, hourly, daily) = try await service.weather(for: location, including: .current, .hourly, .daily)
            
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
    
    func convertToAddress(location: CLLocation) -> String {
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // 1
            if let error = error {
                print(error)
            }
                    
            // 2
            guard let placemark = placemarks?.first else { return }
            print(placemark)
            // Geary & Powell, Geary & Powell, 299 Geary St, San Francisco, CA 94102, United States @ <+37.78735352,-122.40822700> +/- 100.00m, region CLCircularRegion (identifier:'<+37.78735636,-122.40822737> radius 70.65', center:<+37.78735636,-122.40822737>, radius:70.65m)
                    
            // 3
            guard let streetName = placemark.thoroughfare else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
                    
            // 4
            return "\(streetName) \(city), \(state)"
        }
    }

}


