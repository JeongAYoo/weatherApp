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

final class MainViewController: UIViewController {
    // MARK: - Properties
    private let currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 240))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
    //    view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
        return view
      }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1.0
        //layout.itemSize = CGSize(width: 100, height: 100)
        return layout
      }()
    
    private let tableView = UITableView()
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    var weatherKitManager = WeatherKitManager()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        //tableView.backgroundColor = .red
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: "DailyWeatherCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupView()
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
    // MARK: - AutoLayout
    func setupView() {
        view.backgroundColor = .lightGray
        tableView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        view.addSubview(currentWeatherView)
        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        print(#function)
        
        currentWeatherView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            //make.height.equalTo(100)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }

    }
    

}

// MARK: - UITableView DataSource
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
// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - UICollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyCollectionViewCell
        return cell
    }

}

// MARK: - UICollectionView DelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 50, height: 100)
        let width = UIScreen.main.bounds.width / 4
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - PreviewProvider
#if DEBUG
import SwiftUI

struct MainVCPreview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif
