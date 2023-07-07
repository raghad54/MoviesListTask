//
//  UserDefault.swift

//
//  Created by R.Soliman on 03/06/2021.

//

import Foundation

// MARK: - ...  UD for single object from Defaults proprties
internal var UD: Defaults {
    if Defaults.Static.instance == nil {
        Defaults.Static.instance = Defaults()
    }
    return Defaults.Static.instance!
}

