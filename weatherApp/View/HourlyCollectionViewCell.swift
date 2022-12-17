//
//  HourlyCollectionViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit
import WeatherKit

final class HourlyCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 3시"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "23C"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hourLabel, weatherImageView,temperatureLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
    
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - AutoLayout
    func setupView() {
        self.backgroundColor = .clear
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(stackView)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(weather: HourlyWeather) {
        hourLabel.text = weather.date
        weatherImageView.image = UIImage(systemName: weather.symbolName)
        temperatureLabel.text = String(Int(round(weather.temperature))) + "°C"
    }
}


// MARK: - PreviewProvider
import SwiftUI

struct CustomCellPreview2: PreviewProvider {
    static var previews: some View {
        CellPreviewContainer().frame(width: UIScreen.main.bounds.width, height: 70, alignment: .center)
    }
    
    struct CellPreviewContainer: UIViewRepresentable {
        func makeUIView(context: UIViewRepresentableContext<CustomCellPreview2.CellPreviewContainer>) -> UICollectionViewCell {
            return HourlyCollectionViewCell()
        }
        func updateUIView(_ uiView: UICollectionViewCell, context: UIViewRepresentableContext<CustomCellPreview2.CellPreviewContainer>) {
        }
        
        typealias UIViewType = UICollectionViewCell
    }
}
