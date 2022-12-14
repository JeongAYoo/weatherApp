//
//  MainView.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/04.
//

import UIKit

final class MainView: UIView {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
//        self.layer.cornerRadius = 5.0
//        self.clipsToBounds = true
        setupView()
        //updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(addButton)
    }
    
//    override func updateConstraints() {
//        setConstraints()
//        super.updateConstraints()
//    }
    
    func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
    }
}
