//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/10.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

import SwiftUI

struct CustomCellPreview: PreviewProvider {
    static var previews: some View {
        CellPreviewContainer().frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
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
