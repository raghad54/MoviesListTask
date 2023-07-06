import CoreData
import UIKit

// MARK: - ...  Functions help the network manager
extension BaseNetworkManager {
    public func slugs(_ method: NetworkConfigration.EndPoint, _ paramters: [Any] = []) -> String {
        var url = method.rawValue
        for key in paramters {
            url += "/\(key)"
        }
        return url
    }
    func safeUrl(url: String) -> String {
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return safeURL
    }
    func queryString(method: String) -> String {
        var genericUrl: String = method
        var counter = 0
        if self.paramaters.count > 0 {
            for (key, value) in self.paramaters {
                if counter == 0 {
                    genericUrl += "?"+key+"=\(value)"
                } else {
                    genericUrl += "&"+key+"=\(value)"
                }
                counter += 1
            }
        }
        return genericUrl
    }
    func setErrorMessage(data: Data?) {
        guard data != nil else { return }
        guard let error = try? JSONDecoder().decode(BaseModel<String>.self, from: data ?? Data()) else { return }
        if error.errors != nil {
            self.makeAlert(error.description(), closure: {})
        } else {
            if error.message != nil {
                self.makeAlert(error.message!, closure: {})
            }
        }
    }
    func getErrorMessage(data: Data?) -> String? {
        guard data != nil else { return "" }
        guard let error = try? JSONDecoder().decode(BaseModel<String>.self, from: data ?? Data()) else { return "" }
        if error.errors != nil {
            return error.description()
        } else {
            if error.message != nil {
                return error.message
            }
        }
        return ""
    }
    
    
    func getError(data: Data?) -> [Errors]? {
        guard data != nil else { return nil }
        guard let error = try? JSONDecoder().decode(BaseModel<String>.self, from: data ?? Data()) else { return nil }
        if error.errors == nil {
            let message = Errors()
            message.value = error.message
            return [message]
        } else {
            return error.errors
        }
    }
    
    
    
}
