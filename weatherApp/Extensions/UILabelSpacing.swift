//
//  UILabelSpacing.swift
//  weatherApp
//
//  Created by Jade Yoo on 2022/12/16.
//

import UIKit

extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = .center
        //style.minimumLineHeight = 20.0
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
