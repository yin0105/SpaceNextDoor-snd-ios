//
//  UILabel.swift
//  WeFresh-iOS
//
//  Created by Tung Do Thanh on 12/12/19.
//  Copyright © 2019 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
}
extension UILabel {
    func applyFontStyle(fontStyle: Font, color: UIColor = .trout, alpha: CGFloat = 1) {
        self.font = fontStyle.font
        self.textColor = color
        self.alpha = alpha
    }
}



// UILabel同理 添加下划线

extension UILabel {
 
    func underline(_ range: NSRange?) {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range ?? NSRange(location: 0, length: attributedString.length))
 
            attributedText = attributedString
        }
    }
}

extension UILabel {
    func animateToFont(_ font: UIFont, withDuration duration: TimeInterval) {
        guard let currentFont = self.font else { return }
        self.font = font
        let currentPosition = frame.origin
        let scale = currentFont.pointSize / font.pointSize
        let currentTranform = transform
        transform = transform.scaledBy(x: scale, y: scale)
        let newPosition = frame.origin
        frame.origin = currentPosition
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newPosition
            self.transform = currentTranform
            self.layoutIfNeeded()
        }
    }
}
