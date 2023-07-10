import CoreData
import Alamofire
// MARK: - ...  NetworkManager
class NetworkManager: BaseNetworkManager, Authorization {
    func setupTimestamp() -> Bool {
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp).int
        var expiration = UD.expiresToken ?? 0
        let loginTimeStamp = UD.loginTimeStamp ?? 0
        if expiration < myTimeInterval {
            return false
        } else {
            return true
        }
    }
    
    
    struct Static {
        static var instance: NetworkManager?
    }
    
    class var instance: NetworkManager {
        if Static.instance == nil {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    
    var useAuth: Bool = NetworkConfigration.useAuth
}

// MARK: - ...  functions
extension NetworkManager {
    
    @discardableResult
    func request<M: Codable>(_ method: String, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) -> DataRequest? {
        if self.useAuth {
            var request: DataRequest?
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    request = super.connection(method, type: type, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
            return request
        } else {
            super.refresh()
            let request = super.connection(method, type: type, BaseModel<M>.self, completionHandler: completionHandler)
            return request
        }
    }
    @discardableResult
    func request<M: Codable>(_ method: NetworkConfigration.EndPoint, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) -> DataRequest? {
        let request = self.request(method.rawValue, type: type, model, completionHandler: completionHandler)
        return request
    }
    @discardableResult
    func requestRaw<M: Codable>(_ method: String, json: Data? = nil, type: HTTPMethod, _ model: M.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) -> DataRequest? {
        if self.useAuth {
            var request: DataRequest?
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    request = super.connectionRaw(method, type: type, json: json, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
            return request
        } else {
            super.refresh()
            let request = super.connectionRaw(method, type: type, json: json, BaseModel<M>.self, completionHandler: completionHandler)
            return request
        }
    }
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [URL]? = [], key: String? = "",
                                      file: [String: URL?]? = nil, _ model: M.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    
    
    func uploadMultiImages<M: Codable>(_ method: String , type: HTTPMethod, files: [UIImage]? = [], key: String? = "",
                                       file: [String: UIImage?]? = nil, _ model: M.Type,
                                       completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.uploadMultiFiles(method, type: type, files: files ?? [], key: key ?? "", file: file, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
    func uploadMultiImagesWithKey<M: Codable>(_ method: String , type: HTTPMethod, files: [String: UIImage]? = [:], key: String? = "",
                                       file: [String: UIImage?]? = nil, _ model: M.Type,
                                       completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if self.useAuth {
            self.refreshToken { callback in
                if callback {
                    super.refresh()
                    super.uploadMultiFiles(method, type: type, files: files ?? [:], file: file, BaseModel<M>.self, completionHandler: completionHandler)
                } else {
                    self.makeAlert("Unauthorized".localized, closure: {
                        Router.instance.unAuthorized()
                    })
                }
            }
        } else {
            super.refresh()
            super.uploadMultiFiles(method, type: type, files: files ?? [:], file: file, BaseModel<M>.self, completionHandler: completionHandler)
        }
    }
}
