//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit

final class DailyTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = .white
        
        return imageView
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "월요일"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        //label.backgroundColor = .yellow
        
        return label
    }()
    
    private let lowHighTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-1도" + " / " + "10도"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        //label.backgroundColor = .orange
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        //stackView.spacing = 20
        
        return stackView
    }()
    
    let formatter = TemperatureFormatter().formatter
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - AutoLayout
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
    }
    
    func setupView() {
        self.backgroundColor = .clear
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(stackView)
        
        [weatherImageView, dayLabel, lowHighTempLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(0.1)
            make.centerY.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(0.45)
            make.centerY.equalToSuperview()
        }
        
        lowHighTempLabel.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(0.45)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    func setData(weather: DailyWeather) {
        weatherImageView.image = UIImage(systemName: weather.symbolName)
        dayLabel.text = weather.date
        
        lowHighTempLabel.text = formatter.string(from: weather.lowTemperature) + " / " + formatter.string(from: weather.highTemperture)
    }
    
}
