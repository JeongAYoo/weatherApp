//
//  ViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/14.
//

import UIKit
import CoreLocation
import WeatherKit

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    var weatherKitManager = WeatherKitManager()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 테스트
        print(latitude, longitude)  // 일단은 이전 뷰컨에서 전달받음
        
//        let shared = WeatherService.init()
//        let service = WeatherService.shared
//        var location = CLLocation(latitude: latitude!, longitude: longitude!)
        Task {
            try await weatherKitManager.getWeather()
        }

        
    }

}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct MainVCPreview: PreviewProvider {
//    
//    static var previews: some View {
//        // view controller using programmatic UI
//        MainViewController().toPreview()
//    }
//}
//#endif
