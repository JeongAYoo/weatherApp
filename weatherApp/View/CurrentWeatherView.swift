//
//  CurrentWeatherView.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIView {
    // MARK: - Properties
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun")
        
        return imageView
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "23C"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "맑음"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let lowHighTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-1도 / " + "10도"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "축축"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "풍속"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let uvIndexLabel: UILabel = {
        let label = UILabel()
        label.text = "자외선"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let upperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let lowerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        return stackView
    }()
    // MARK: - Initializer
    override init(frame: CGRect) {
        //print(#function)
        super.init(frame: frame)

        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Set up Views, Constraints
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setUpView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        
        self.addSubview(rootStackView)
        
        [locationNameLabel, upperStackView, middleStackView, lowerStackView].forEach {
            rootStackView.addArrangedSubview($0)
        }
        
        [weatherImageView, currentTempLabel].forEach {
            upperStackView.addArrangedSubview($0)
        }
        
        [conditionLabel, lowHighTempLabel].forEach {
            middleStackView.addArrangedSubview($0)
        }
        
        [humidityLabel, windSpeedLabel, uvIndexLabel].forEach {
            lowerStackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        rootStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        upperStackView.snp.makeConstraints { make in
            make.height.equalTo(50) // 비율이 나은가?
        }
    }
    
}

