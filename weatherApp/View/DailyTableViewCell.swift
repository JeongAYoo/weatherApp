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
        stackView.spacing = 20
        
        return stackView
    }()
    
    // MARK: - Initializers
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
        //self.layer.shadowColor = UIColor.black.cgColor
        //self.layer.shadowOpacity = 0.5
        //self.layer.shadowRadius = 5
        //self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.backgroundColor = .clear
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.addSubview(stackView)
        
        [weatherImageView, dayLabel, lowHighTempLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1)
            make.centerY.equalToSuperview()
            //make.leading.equalToSuperview().offset(20)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.centerY.equalToSuperview()
        }
        
        lowHighTempLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            //make.right.equalToSuperview().offset(-20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            //make.width.equalTo(contentView)
            make.height.equalTo(60)
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
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
