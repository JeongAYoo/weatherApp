//
//  Extensions.swift
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

extension UIViewController {
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor(red: 131/255, green: 166/255, blue: 247/255, alpha: 1).cgColor]
        gradient.locations = [0, 1] // 화면의 top to bottom 전체에 위치
        //gradient.opacity = 0.8
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}

extension UIView {
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(displayP3Red: 70/255, green: 106/255, blue: 192/255, alpha: 1).cgColor, UIColor(displayP3Red: 131/255, green: 166/255, blue: 247/255, alpha: 1).cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
        gradient.frame = frame
    }
}
