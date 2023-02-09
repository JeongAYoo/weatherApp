//
//  MainLocation.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/02/09.
//

import CoreLocation

class MainLocation {
    static let shared = MainLocation()
    
    var value: CLLocation?
    
    private init() {}
}
