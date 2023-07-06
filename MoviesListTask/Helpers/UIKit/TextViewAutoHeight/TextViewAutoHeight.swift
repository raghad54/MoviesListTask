//
//  TextViewAutoHeight.swift
//  Mutsawiq
//
//  Created by M.abdu on 12/7/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

private var textViews: [UITextView: String] = [:]
private var textViewsHeight: [UITextView: CGFloat] = [:]
// MARK: - ...  text View delegate
extension UITextView: UITextViewDelegate {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return textViews[self] ?? ""
        }
        set {
            textViews[self] = newValue.localized
            if Localizer.current == .arabic {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
            self.text = textViews[self]
            self.textViewDidEndEditing(self)
        }
    }
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var autoHeight: Bool {
        get {
            return self.autoHeight
        }
        set {
            if newValue {
                self.delegate = self
            }
        }
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == textView.localization {
            textView.text = textView.localization
            if #available(iOS 13.0, *) {
                textView.textColor = .placeholderText
            } else {
                // Fallback on earlier versions
            }
        } else {
            textView.textColor = R.color.textColor()
        }
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textView.localization {
            textView.text = ""
        }
        textView.textColor = R.color.textColor()
    }
    public func textViewDidChange(_ textView: UITextView) {
        if let height = textView.constraints.first(where: { $0.firstAttribute == .height }) {
            if textViewsHeight[self] == nil {
                textViewsHeight[self] = height.constant
            }
            var textHeight = textView.text.heightWithConstrainedWidth(width: textView.width, font: textView.font ?? .systemFont(ofSize: 15))
            //print(textHeight)
            if textHeight > 300 {
                textHeight = 300
            }
            if textHeight <= textViewsHeight[self] ?? 60 {
                height.constant = textViewsHeight[self] ?? 60
            } else {
                height.constant = textHeight + 20
            }
        }
        
    }
}
