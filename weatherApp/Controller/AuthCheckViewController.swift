//
//  AuthCheckViewController.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/11/28.
//

import UIKit
import CoreLocation

final class AuthCheckViewController: UIViewController, CLLocationManagerDelegate {
    // MARK: - Properties
    /// 인증 허용 질문 레이블
    private let askAuthLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 위치를 기반으로\n날씨 정보를 확인하시겠어요?"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    /// 허용 버튼
    private let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("네, 현재 위치로 확인할게요.", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(getLocationUsagePermission), for: .touchUpInside)
        
        return button
    }()
    
    /// 불허용 버튼
    private let noButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니요, 지역을 지정할게요.", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(noButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    
    var locationManager: CLLocationManager!
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // MARK: - AutoLayout
    func setupView() {
        
        view.backgroundColor = .white
        
        [askAuthLabel, stackView].forEach { view.addSubview($0)}
        
        stackView.addArrangedSubview(yesButton)
        stackView.addArrangedSubview(noButton)
        
        askAuthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets).offset(-100)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(120)
        }
    }
    
    /// 검색 화면으로 이동하는 함수
    @objc func noButtonClicked() {
        presentSearchView()
    }
    
    /// 위치 권한 허용 묻는 함수
    @objc func getLocationUsagePermission() {
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let space = locationManager.location?.coordinate
        latitude = space?.latitude
        longitude = space?.longitude
        
        presentMainView()
    }
    
    func presentSearchView() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func presentMainView() {
        let vc = MainViewController()
        vc.latitude = self.latitude
        vc.longitude = self.longitude
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            break
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
            presentSearchView()
        case .denied:
            print("GPS 권한 요청 거부됨")
            getLocationUsagePermission()
            presentSearchView()
            
        default:
            print("GPS: Default")
        }
    }
}

//#if DEBUG
//import SwiftUI
//
//@available(iOS 13, *)
//struct AuthCheckVCPreview: PreviewProvider {
//    static var previews: some View {
//        // view controller using programmatic UI
//        AuthCheckViewController().toPreview()
//    }
//}
//#endif
