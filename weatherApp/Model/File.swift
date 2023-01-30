//
//  File.swift
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
}
