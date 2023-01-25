//
//  SearchResultTableViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2023/01/25.
//

import UIKit
import SnapKit

class SearchResultTableViewCell: UITableViewCell {
    // MARK: - Properties
    var regionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "SearchResultTableViewCell")
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .lightGray
        } else {
            self.backgroundColor = .none
        }
    }
    
    func setConstrains() {
        addSubview(regionLabel)
        
        regionLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }

}
