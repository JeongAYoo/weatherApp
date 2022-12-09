//
//  HourlyCollectionViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "3시"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "23C"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
}
