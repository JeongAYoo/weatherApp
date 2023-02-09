//
//  MenuCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/02/09.
//

import UIKit
import SnapKit

class MenuCell: UITableViewCell {
    // MARK: - Properties
    private let label: UILabel = {
        let label = UILabel()
        label.text = "텍스트"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()

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
    
    // MARK: - Helpers
    func setupView() {
        backgroundColor = .clear
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().offset(20)
        }
    }
    
    func setData(_ cityName: String) {
        label.text = cityName
    }
}
