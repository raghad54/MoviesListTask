//
//  UIFontEx.swift
//  DAL_IOS
//
//  Created by R.Soliman on 12/27/20.
//

import Foundation
import UIKit
extension UILabel {
    
    @IBInspectable var fontLabel: String {
        set {
            if let first = newValue.first {
                guard newValue.count > 2 else {
                    return}
                if let size = Double(newValue[1..<newValue.count]) {
                    if first == "b" {
                        self.font = ThemeApp.Fonts.boldFont(size: CGFloat(size))
                    } else if  first == "m" {
                        self.font = ThemeApp.Fonts.mediumFont(size: CGFloat(size))
                    } else if  first == "r" {
                        self.font = ThemeApp.Fonts.regularFont(size: CGFloat(size))
                    } else if  first == "l" {
                        self.font = ThemeApp.Fonts.lightFont(size: CGFloat(size))
                    }
                }
            }
        } get { return "" }
    }
}

extension UIButton {
    @IBInspectable
    var fontLabel: String {
        set {
            if let first = newValue.first {
                if let size = Double(newValue[1..<newValue.count]) {
                    if first == "b" {
                        self.titleLabel?.font = ThemeApp.Fonts.boldFont(size: CGFloat(size))
                    } else if  first == "m" {
                        self.titleLabel?.font = ThemeApp.Fonts.mediumFont(size: CGFloat(size))
                    } else if  first == "r" {
                        self.titleLabel?.font = ThemeApp.Fonts.regularFont(size: CGFloat(size))
                    } else if  first == "l" {
                        self.titleLabel?.font = ThemeApp.Fonts.lightFont(size: CGFloat(size))
                    }
                }
            }
        } get {return ""}
    }
}
extension UITextField {
    @IBInspectable var fontLabel: String {
        set {
            if Localizer.current == .arabic {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
            if let first = newValue.first {
                guard newValue.count > 2 else {
                    return }
                if let size = Double(newValue[1..<newValue.count]) {
                    if first == "b" {
                        self.font = ThemeApp.Fonts.boldFont(size: CGFloat(size))
                    } else if  first == "m" {
                        self.font = ThemeApp.Fonts.mediumFont(size: CGFloat(size))
                    } else if  first == "r" {
                        self.font = ThemeApp.Fonts.regularFont(size: CGFloat(size))
                    }
                    else if  first == "l" {
                       self.font = ThemeApp.Fonts.lightFont(size: CGFloat(size))
                   }
                }
            }
        } get { return "" }
    }
}
extension UITextView {
    @IBInspectable var fontLabel: String {
        set {
            if let first = newValue.first {
                guard newValue.count > 2 else {
                    return}
                if let size = Double(newValue[1..<newValue.count]) {
                    if first == "b" {
                        self.font = ThemeApp.Fonts.boldFont(size: CGFloat(size))
                    } else if  first == "m" {
                        self.font = ThemeApp.Fonts.mediumFont(size: CGFloat(size))
                    } else if  first == "r" {
                        self.font = ThemeApp.Fonts.regularFont(size: CGFloat(size))
                    } else if  first == "l" {
                        self.font = ThemeApp.Fonts.lightFont(size: CGFloat(size))
                    }
                }
            }
        } get {return ""}
    }
}
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
