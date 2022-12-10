//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit
import SnapKit

class DailyTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "월요일"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let lowHighTempLabel: UILabel = {
        let label = UILabel()
        label.text = "-1도" + " / " + "10도"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Set up Views, Constraints
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    func setUpView() {
        //self.backgroundColor = .yellow

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 10, height: 20)
        contentView.backgroundColor = .green
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        //contentView.layer.shadowOffset = CGSize(width: 10, height: 20)
        
        self.addSubview(stackView)
        
        [weatherImageView, dayLabel, lowHighTempLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        dayLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        lowHighTempLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
}

// MARK: - PreviewProvider
import SwiftUI

struct CustomCellPreview: PreviewProvider {
    static var previews: some View {
        CellPreviewContainer().frame(width: UIScreen.main.bounds.width - 20, height: 70, alignment: .center)
    }
    
    struct CellPreviewContainer: UIViewRepresentable {
        func makeUIView(context: UIViewRepresentableContext<CustomCellPreview.CellPreviewContainer>) -> UITableViewCell {
            return DailyTableViewCell()
        }
        func updateUIView(_ uiView: UITableViewCell, context: UIViewRepresentableContext<CustomCellPreview.CellPreviewContainer>) {
        }
        
        typealias UIViewType = UITableViewCell
    }
}
