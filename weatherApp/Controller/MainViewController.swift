//
//  ViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/14.
//

import UIKit
import SnapKit
import CoreLocation
import WeatherKit

class MainViewController: UIViewController {
    
    //private let mainView = MainView()
    private let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 240))
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        tableView.rowHeight = 60
        //tableView.backgroundColor = .red
        
        /// 셀 등록
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        
        setUpView()
        setConstraints()
        
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
    
//    override func updateViewConstraints() {
//        setConstraints()
//    }
    
    func setUpView() {
        view.backgroundColor = .lightGray
        tableView.backgroundColor = .clear
        view.addSubview(currentWeatherView)
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        
        print(#function)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
//        currentWeatherView.snp.makeConstraints { make in
//            make.top.equalTo(self.view.safeAreaLayoutGuide)
//            make.leading.equalTo(self.view.safeAreaLayoutGuide)
//            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
//        }
        
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            currentWeatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            currentWeatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            currentWeatherView.heightAnchor.constraint(equalToConstant: 200),
            tableView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
//        tableView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(currentWeatherView.snp.bottom).offset(20)
//            //make.centerY.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }

    }
    

}

// MARK: - extension TableView DataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyTableViewCell

        print(#function)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
}

#if DEBUG
import SwiftUI

struct MainVCPreview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif
