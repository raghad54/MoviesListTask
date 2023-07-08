//
//  Defaults.swift

//
//  Created by R.Soliman on 14/06/2021.

//

import Foundation

// MARK: - ...  Defaults properties
internal class Defaults {
    struct Static {
        static var instance: Defaults?
    }
    
    @StoredDefaults("USER_LOGIN_REMEMBER")
    var LoginRemember: Bool?
    
    @StoredDefaults("expires_in")
    var expiresToken: Int?
    
    @StoredDefaults("LOGIN_TIMESTAMP")
    var loginTimeStamp: Int?
    
    @StoredDefaults("DEVICE_TOKEN")
    var DEVICE_TOKEN: String?
    
    @StoredDefaults("locale")
    var locale: String?
    
    @StoredDefaults("default.language.ia")
    var defaultLangauge: String?
    
    @StoredDefaults("isLogin")
    var isLogin: Bool?
   
}
