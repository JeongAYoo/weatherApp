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
        let view = CurrentWeatherView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 250))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
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
    var testLocation = CLLocation(latitude: 37.5326, longitude: 127.0246) {
        didSet {
            setupData()
        }
    }
    
    var hourlyWeatherArray: [HourlyWeather]?
    var dailyWeatherArray: [DailyWeather]?
    var weatherKitManager = WeatherKitManager.shared
    private var geocoder: CLGeocoder!
    var isSearched: Bool = false
    
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
        //print(latitude!, longitude!)  // 일단은 이전 뷰컨에서 전달받음
        //weatherKitManager.currentLocation = CLLocation(latitude: self.latitude!, longitude: self.longitude!)
        //weatherKitManager.currentLocation = CLLocation(latitude: 37.5326, longitude: 127.0246)
        
        setupData()
    }
    
    func setupData() {
        Task {
            try await weatherKitManager.fetchWeather(location: testLocation) { current, hourly, daily in
                //currentWeatherView.setData(weather: weatherKitManager.getCurrentWeather()!)
                //hourlyWeatherArray = weatherKitManager.getHourlyWeather()!
                //dailyWeatherArray = weatherKitManager.getDailyWeather()!
                self.currentWeatherView.setData(weather: current!)
                self.hourlyWeatherArray = hourly!
                self.dailyWeatherArray = daily!
                print(self.dailyWeatherArray!)
                
                DispatchQueue.main.async {
                    //self.currentWeatherView.setNeedsLayout()
                    //self.currentWeatherView.setData(weather: current!)
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - AutoLayout
    func setupView() {
        if !isSearched {
            setNavigationBar()
        } else {
            setSearchResultNavigationBar()
        }
    
        view.backgroundColor = .lightGray
        tableView.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        view.addSubview(currentWeatherView)
        view.addSubview(tableView)
        view.addSubview(collectionView)
    }
    
    func setNavigationBar() {
        // 내비게이션바 설정
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance

        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance

        navigationController?.setNeedsStatusBarAppearanceUpdate()
                
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

        title = "날씨"
    }
    
    func setSearchResultNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(resultDismiss))
        // TODO: - Add save button, actions for saving new location
        
        title = "검색 지역 날씨"

    }
    
    func setConstraints() {
        print(#function)
        
        currentWeatherView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            //make.height.equalTo(250)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(UIScreen.main.bounds.width / 5 * 1.5)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    // MARK: - Action
    @objc func listButtonTapped() {
        
    }
    
    @objc func addButtonTapped() {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func resultDismiss() {
        self.dismiss(animated: true)
    }
}

// MARK: - UITableView DataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyTableViewCell
        
        guard let data = dailyWeatherArray?[indexPath.row] else { return cell }
        cell.setData(weather: data)
        return cell
    }
    
    
}
// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    
}

// MARK: - UICollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyCollectionViewCell
        guard let data = hourlyWeatherArray?[indexPath.row] else { return cell }
        cell.setData(weather: data)
        return cell
    }

}

// MARK: - UICollectionView DelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 50, height: 100)
        let width = UIScreen.main.bounds.width / 5
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
