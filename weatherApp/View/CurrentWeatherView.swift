//
//  CurrentWeatherView.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
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
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "23C"
        //label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28)
        
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
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "풍속"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let uvIndexLabel: UILabel = {
        let label = UILabel()
        label.text = "자외선"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private let updateTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 시각: "
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        label.textColor = .darkGray
        
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

        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - AutoLayout
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        
        [humidityLabel, windSpeedLabel, uvIndexLabel].forEach { UILabel in
            UILabel.setLineSpacing(spacing: 5)
        }
        
        self.addSubview(rootStackView)
        
        [locationNameLabel, upperStackView, middleStackView, lowerStackView, updateTimeLabel].forEach {
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
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        upperStackView.snp.makeConstraints { make in
            make.height.equalTo(50) // 비율이 나은가?
        }
    }
    
    func setData(weather: CurrentWeather) {
        weatherImageView.image = UIImage(systemName: weather.symbolName)
        currentTempLabel.text = String(weather.temperature) + "°C"
        conditionLabel.text = weather.condition
        humidityLabel.text = "습도\n" + String(weather.humidity)
        windSpeedLabel.text = "풍속\n" + String(weather.windSpeed)
        uvIndexLabel.text = "자외선\n" + String(weather.uvIndex)
        updateTimeLabel.text! += weather.date
    }
}

