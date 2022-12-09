//
//  ViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/14.
//

import UIKit
import CoreLocation
import WeatherKit
import SnapKit

class MainViewController: UIViewController {
    
    //private let mainView = MainView()
    private let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView(frame: CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width - 20, height: 200))
        //view.backgroundColor = .or
        return view
    }()
    
    private let tableView = UITableView()
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    var weatherKitManager = WeatherKitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setUpView()
        setConstraints()
        
        //tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: "HourlyWeatherCell")
        //tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: "DailyWeatherCell")

        // 테스트
//        print(latitude, longitude)  // 일단은 이전 뷰컨에서 전달받음
//
////        let shared = WeatherService.init()
////        let service = WeatherService.shared
////        var location = CLLocation(latitude: latitude!, longitude: longitude!)
//        Task {
//            try await weatherKitManager.getWeather()
//        }
        
    }
    
    func setUpView() {
        view.backgroundColor = .blue
        view.addSubview(currentWeatherView)
    }
    
    func setConstraints() {
        
//        currentWeatherView.snp.makeConstraints { make in
//            //make.top.equalToSuperview()
//            //make.leading.equalToSuperview()
//            //make.trailing.equalToSuperview()
//        }
    }
    

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyTableViewCell

        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
}

//#if DEBUG
//import SwiftUI
//
//struct MainVCPreview: PreviewProvider {
//
//    static var previews: some View {
//        // view controller using programmatic UI
//        MainViewController().toPreview()
//    }
//}
//#endif
