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
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("메인 뷰 컨트롤러")  //테스트용

        print(latitude, longitude)  // 일단은 이전 뷰컨에서 전달받음
        
        setUpView()
    }

    func setUpView() {
        view.backgroundColor = .green
        
        let addButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.tintColor = .black
            button.backgroundColor = .white
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            
            return button
        }()
        
        view.addSubview(addButton)
        
        // 레이아웃
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
}

