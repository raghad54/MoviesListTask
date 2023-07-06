//
//  Localization.swift
//  SupportI
//
//  Created by R.Soliman on 2/13/20.
//  Copyright © 2020 R.Soliman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Constants
public func initLang() {
    Localizer.initLang()
}
public func getAppLang() -> Languages {
    return Localizer.current
}
public func setAppLang(_ lang: Languages) {
    Localizer.set(language: lang)
}
final class Localizer: NSObject {
    public static func initLang() {
        if current == .arabic {
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UILabel.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().semanticContentAttribute = .forceRightToLeft
            UITextView.appearance().semanticContentAttribute = .forceRightToLeft
            UIButton.appearance().semanticContentAttribute = .forceRightToLeft
            UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
            UICollectionViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITableViewCell.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
            UISearchBar.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UILabel.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().semanticContentAttribute = .forceLeftToRight
            UITextView.appearance().semanticContentAttribute = .forceLeftToRight
            UIButton.appearance().semanticContentAttribute = .forceLeftToRight
            UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            UICollectionViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITableViewCell.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
            UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    public static func getLocale() -> String {
        if let locale = UD.locale {
            return locale
        } else {
            return "ar_EG"
        }
    }
    public static let defaultSign = Bundle.main.preferredLocalizations[0]
    /**
     Get available languages from main bundle
     - returns: array of languages signs
     */
    public static func getSelectedLanguages() -> [String] {
        var languages = Bundle.main.localizations
        if let baseIndex = languages.firstIndex(of: "Base") {
            languages.remove(at: baseIndex)
        }
        return languages
    }
    /**
     Get default language or saved language
     - returns: language sign string
     */
    static var current: Languages {
        let lang = UD.defaultLangauge ?? defaultSign
        return Languages(lang) ?? .arabic
    }
    /**
     Get if changed lang before
     - returns: language sign string
     */
    static var isChanged: Bool {
        let string = UD.defaultLangauge
        return (string != nil) ? true : false
    }
    /**
     Save language and put it default
     - parameter language: may be language sign to save it
     - returns: void
     */
    static func set(language: Languages) {
        DispatchQueue.main.async {
            let lang = getSelectedLanguages().contains(language.rawValue) ? language.rawValue : defaultSign
            guard lang != current.rawValue else { return }
            UD.defaultLangauge = lang
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .languageDidChanged, object: lang)
            Localizer.initLang()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
                Router.instance.restart()
                Localizer.initLang()
            }
        }
    }
}

extension Localizer {
    static func changeLang() {
        let alert = UIAlertController(title: "Change language".localized, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "العربية", style: .default, handler: { _ in
            setAppLang(.arabic)
        }))
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            setAppLang(.english)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel".localized, style: .cancel, handler: nil))
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.permittedArrowDirections = .up
                alert.popoverPresentationController?.sourceView = UIApplication.topViewController()?.view
            default:
                break
        }
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    /**
      Activate Localization Helper
      **@param** swizzleExtensions Bool if you want to use run time swizzle with all Views like uilabel, default is false...
      **@note** swizzling extension could lead to issues if you are swizzling your UIViews **layoutSubviews** method from another place
      */
      static func activate(_ swizzleExtensions: Bool = false) {
         swizzle(class: Bundle.self, sel: #selector(Bundle.localizedString(forKey:value:table:)), override: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
     }
}
extension Localizer {
    // MARK: - Utility
    /// Exchange the implementation of two methods for the same Class override will replace sel
    static func swizzle(class cls: AnyClass, sel: Selector, override: Selector) {
        guard let origMethod: Method = class_getInstanceMethod(cls, sel) else { return }
        guard let overrideMethod: Method = class_getInstanceMethod(cls, override) else { return }
        if (class_addMethod(cls, sel, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, override, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
        } else {
            method_exchangeImplementations(origMethod, overrideMethod);
        }
    }
}

// MARK: - Notifications.Name
extension Notification.Name {
    static var languageDidChanged: Notification.Name {
        return Notification.Name("language.did.changed.ia")
    }
}

// MARK: - Strings
extension String {
    /// get localize string for key from localizable files
    var localized: String {
        let char = "\""
        print("\(char)\(self)\(char) = \(char) \(char);")
        guard let languageStringsFilePath = Bundle.main.path(forResource: Localizer.current.rawValue, ofType: "lproj") else {
            return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        }
        return Bundle(path: languageStringsFilePath)?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}

// MARK: - Bundle
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        // check if its the main bundle then if the bundle of the current language is available
        // then try without locale
        // if not go back to base
        let translate =  { (tableName: String?) -> String in
            let currentLanguage = Localizer.current // with locale
            let languageWithoutLocale = "en"        // without locale
            var bundle = Bundle()
            // normal case where the lang with locale working
            if let _path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } // en case when its working wihout locale
            else if let _path = Bundle.main.path(forResource: languageWithoutLocale, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } // current locale not exist , so we fallback
            else if let _path = Bundle.main.path(forResource: languageWithoutLocale, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
        // normal case
        if self == Bundle.main {
            return translate(tableName)
        } // let the bundle handle the locale
        else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}
