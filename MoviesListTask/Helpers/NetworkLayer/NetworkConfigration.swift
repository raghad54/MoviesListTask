//
//  EndPoint.swift
//  SupportI
//
//  Created by R.Soliman on 3/20/20.
//  Copyright © 2020 R.Soliman. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Network layer configration
struct NetworkConfigration {
    static let URL = ""
    static let VERSION = "v1"
    static var useAuth: Bool = false
    // MARK: - ...  The Endpoints
    public enum EndPoint: String {
        case register = "create-account"
        case token
        case login
        case logout
        case resendCode
        case forget = "forget-password"
        case reset = "reset-password"
    }
}

extension NetworkConfigration.EndPoint {
    static func endPoint(point: NetworkConfigration.EndPoint, paramters: [Any]) -> String {
        let method = NetworkManager.instance.slugs(point, paramters)
        return method
    }
}

