//
//  UserCity.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/01/30.
//

import Foundation
import RealmSwift
import CoreLocation

enum CityNameType {
    case short
    case long
}

class UserCity: Object {
    @Persisted var cityName: String
    @Persisted var latitude: Double
    @Persisted var longitude: Double

    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(cityName: String, latitude: Double, longitude: Double) {
        self.init()
        
        self.cityName = cityName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func locationToString(_ location: CLLocation, type: CityNameType, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") //korea
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: local) { (placemarks, error) in
            
            if let error = error {
                print(error)
            }
            
            guard let placemark = placemarks?.first else { return }
            print(placemark)
            
            let streetName = placemark.thoroughfare ?? ""
            guard let city = placemark.locality else { return }
            
            print("UserCity: \(streetName), \(city)")
            
            switch type {
            case .short:
                completion("\(city)")
            case .long:
                completion("\(streetName), \(city)")
            }
        }
    }
}
