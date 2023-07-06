//
//  LanguangeEnum.swift
//  SupportI
//
//  Created by R.Soliman on 4/20/20.
//  Copyright © 2020 R.Soliman. All rights reserved.
//

import Foundation

public enum Languages: String {
    case arabic = "ar"
    case english = "en"
    case frensh = "fr"
    
    init?(_ caseName: String) {
        switch caseName {
            case "ar": self.init(rawValue: "ar")
            case "en": self.init(rawValue: "en")
            case "fr": self.init(rawValue: "fr")
            default: self.init(rawValue: "")
        }
    }
}
