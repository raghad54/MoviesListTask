//
//
//    Create by imac on 29/4/2018
//    Copyright © 2018. All rights reserved.

import Foundation
import UIKit
// MARK: - ...  UserAuth Controller
class UserRoot: Codable {
    var data: User?
    var expire: Int?
    //var access_token: String?
    var token: String?
    var refresh_token: String?
    var loginTimeStamp: Int?
}
// MARK: - ...  User Codable from API
extension UserRoot {
    class User: Codable {
        var email: String?
        enum CodingKeys: String, CodingKey {
            case email
        }
    }
}
// MARK: - ...  Functions
extension UserRoot {
    // MARK: - ...  Function for Save user data
    public func save() {
        UD.user = self
    }
    // MARK: - ...  Function for fetch user data
    public static func fetch() -> UserRoot? {
        let user = UD.user
        return user
    }
    // MARK: - ...  Function for fetch token 
    public static func token() -> String? {
        let user = UD.user
        return user?.token
    }
    // MARK: - ...  Function for logout user
    public static func logout() {
        UD.user = UserRoot()
    }
    // MARK: - ...  Function for logout user
    public func logout() {
        UD.user = UserRoot()
    }
    // MARK: - ...  Function for fetch user data
    public static func user() -> User? {
        let user = UD.user
        return user?.data
    }
}
