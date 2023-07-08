import CoreData
private var runningFile: Bool = false
// MARK: - ...  protocol for Authorization refresh token
protocol Authorization: AnyObject {
    var running: Bool { get set }
    func setupTimestamp() -> Bool
    func refreshToken(_ completionHandler: @escaping (Bool) -> Void)
}

extension Authorization {
    // MARK: - ...  Running Request
    var running: Bool {
        set {
            runningFile = newValue
        } get {
            return runningFile
        }
    }
    // MARK: - ...  checkTimeStamp
    //    func setupTimestamp() -> Bool {
    //        //return true
    //        let timestamp = NSDate().timeIntervalSince1970
    //        let myTimeInterval = TimeInterval(timestamp).int
    ////        var expiration = UD.expiresToken ?? 0
    ////        let loginTimeStamp = UD.loginTimeStamp ?? 0
    ////        expiration += loginTimeStamp
    //        //        if expiration > 0{
    //        //            let time = NSDate(timeIntervalSince1970: TimeInterval(expiration))
    //        //        }
    ////        if expiration < myTimeInterval {
    ////            return false
    ////        } else {
    ////            return true
    //        }
    //    }
    // MARK: - ...  CheckRefreshToken
    func refreshToken(_ completionHandler: @escaping (Bool) -> Void) {
        //        if UserRoot.fetch()?.refresh_token != nil {
        //            if !running {
        //                running = true
        //                if !setupTimestamp() {
        //                    NetworkManager.instance.paramaters["refresh_token"] = UserDefaults.standard.string(forKey: "refresh_token")
        //                    NetworkManager.instance.request(.token, type: .post, TokenModel.self) { (response) in
        //                        self.running = false
        //                        switch response {
        //                            case .success(let data):
        //                                if data?.access_token != nil {
        //                                    let defaults = UserDefaults.standard
        //                                    defaults.set(data?.access_token ?? "", forKey: "access_token")
        //                                    defaults.set(data?.expires_in ?? "", forKey: "expires_in")
        //                                    defaults.set(data?.refresh_token ?? "", forKey: "refresh_token")
        //                                    completionHandler(true)
        //                                } else {
        //                                    completionHandler(false)
        //                                }
        //                            case .failure(let error):
        //                                print(error?.localizedDescription ?? "")
        //                                completionHandler(false)
        //                        }
        //                    }
        //                } else {
        //                    running = false
        //                    completionHandler(true)
        //                }
        //            } else {
        //                running = false
        //                completionHandler(true)
        //            }
        //        } else {
        //            completionHandler(true)
        //        }
        // }
    }
}
    
    
    
    struct Authentication {
        static let shared = Authentication()
        let key = "key ASFDSFVGHJGKGI7U6543REDFBHNJ"
    
        func getAuthSecretKey() -> [String: String]? {
            return ["Authorization"  : key]
        }
    
        func getAuthHeader() -> [String: String]? {
            return ["Authorization"  : getAuth()]
        }
    
    
        func getAuth() -> String {
//            if UserRoot.token() == nil {
//                return key
//            } else {
//                return "Bearer " + (UserRoot.token() ?? "")
//            }
            return ""
        }
    }

