//
//  Theme.swift
//  DAL_IOS
//
//  Created by R.Soliman on 12/27/20.
//

import Foundation
import UIKit
struct ThemeApp {
    struct Fonts {
        static func lightFont(size: CGFloat) -> UIFont {
            return  UIFont.init(name: "NeoSansArabic-Light", size: size) ?? UIFont.systemFont(ofSize: size , weight: .light)
        }
        static func regularFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "NeoSansArabic", size: size) ?? UIFont.systemFont(ofSize: size , weight: .regular)
        }
        static func mediumFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "NeoSansArabic-Medium", size: size) ??  UIFont.systemFont(ofSize: size  , weight: .medium)
        }
        static func boldFont(size: CGFloat) -> UIFont {
            return UIFont.init(name: "NeoSansArabic-Bold", size: size) ??   UIFont.systemFont(ofSize: size , weight: .bold)
        }
        static func mainFont() -> UIFont {
            return UIFont.systemFont(ofSize: 17)
        }
    }
}
