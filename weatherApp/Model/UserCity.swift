//
//  UserCity.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/01/30.
//

import Foundation
import RealmSwift

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
}
