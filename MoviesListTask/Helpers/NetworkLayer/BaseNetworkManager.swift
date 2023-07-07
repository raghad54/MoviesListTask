import Alamofire
import UIKit

// MARK: - ...  Base Network manager // downloader // paginator // alertable
class BaseNetworkManager: Downloader, Paginator, Alertable {
    private let url = NetworkConfigration.URL
    private var header: HTTPHeaders {
        get {
            return .init(headers)
        }
    }
    var paramaters: [String: Any] = [:]
    var headers: [HTTPHeader] = []
    var isHttpRequestRun: Bool = false
    override init() {
        super.init()
        setupObject()
        //        tryNetwork(url: "www.google.com")
        //        subscribeNotification()
    }
}
// MARK: - ...  Functions setup
extension BaseNetworkManager {
    // MARK: - ...  refresh for new request
    func refresh() {
        setupObject()
    }
    // MARK: - ...  setup request object
    func setupObject() {
        headers.removeAll()
        //hide()
        setupAuth()
        headers.append(.init(name: "version", value: NetworkConfigration.VERSION))
        headers.append(.init(name: "lang", value: Localizer.current.rawValue))
        headers.append(.init(name: "LOCALE-CODE", value: Localizer.current.rawValue))
    }
    // MARK: - ...  setup auth header
    func setupAuth() {
        headers.append(.init(name: "Authorization", value: Authentication.shared.getAuth()))
    }
    // MARK: - ...  reset the object
    func resetObject() {
        self.paramaters = [:]
        setupObject()
    }
    // MARK: - ...  initailize the FULL URL
    func initURL(method: String, type: HTTPMethod) -> String {
        var url = ""
        if type == .get {
            let methodFull = queryString(method: method)
            url = self.url+methodFull
        } else {
            url = self.url+method
        }
        return url
    }
    func checkReachability() -> Bool {
        if !Reachability.isConnectedToNetwork() {
           // Router.instance.networkFail()
            return false
        } else {
            return true
        }
    }
}
// MARK: - ...  Handle response for request
extension BaseNetworkManager {
    func response<M: Codable>(response: DataResponse<Any, AFError>, _ model: BaseModel<M>.Type ,completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        print(response.value ?? "")
        self.isHttpRequestRun = false
        switch response.result {
            case .success:
                switch response.response?.statusCode {
                    case 200?:
                        do {
                            guard let data = response.data else { return }
                            let model = try JSONDecoder().decode(M.self, from: data)
                            completionHandler(.success(model))
                        } catch DecodingError.typeMismatch(let type , let context) {
                            let error = "Type \(type) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.keyNotFound(let key, let context) {
                            let error = "Key \(key) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.valueNotFound(let value, let context) {
                            let error = "Value \(value) mismatch: \(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            print(error)
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch DecodingError.dataCorrupted(let context) {
                            let error = "\(context.debugDescription)/n/n codingPath: \(context.codingPath)"
                            return completionHandler(.failure(NetworkError.init(message: error)))
                        } catch {
                            return completionHandler(.failure(error))
                        }
                    case 201?:
                        do {
                            let model = try JSONDecoder().decode(BaseModel<M>.self, from: response.data ?? Data())
                            completionHandler(.success(model.data))
                        } catch { return completionHandler(.failure(error)) }
                    case 400?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = NetworkError.init(errors: getError(data: (response.data ?? Data()) ))
                        completionHandler(.failure(error))
                    case 401?:
                        UIApplication.topViewController()?.stopLoading()
                        Router.instance.unAuthorized()
                    case 404?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 422?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 426?:
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: getErrorMessage(data: response.data ?? Data()) ?? "")
                        completionHandler(.failure(error))
                    case 503?:
                       break
                    case .none:
                        break
                    case .some(let error):
                        UIApplication.topViewController()?.stopLoading()
                        let error: NetworkError = .init(message: error.string)
                        completionHandler(.failure(error))
                }
            case .failure(let error):
                UIApplication.topViewController()?.stopLoading()
                self.makeAlert(error.localizedDescription, closure: {})
            //self.show()
        }
    }
}
// MARK: - ...  Connections
extension BaseNetworkManager {
    // MARK: - ...  Basic request with type
    @discardableResult
    func connection<M: Codable>(_ method: String, type: HTTPMethod, _ model: BaseModel<M>.Type,
                                completionHandler: @escaping (NetworkResponse<M>) -> Void) -> DataRequest? {
        if !checkReachability() {
            return nil
        }
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        print(paramters)
        self.resetObject()
        let request = AF.request(safeUrl(url: url), method: type, parameters: paramters, headers: self.header)
            .responseJSON { response in
                self.response(response: response, model, completionHandler: completionHandler)
            }
        return request
    }
    // MARK: - ...  Advanced request for raw with json object
    @discardableResult
    func connectionRaw<M: Codable>(_ method: String, type: HTTPMethod, json: Data? = nil, _ model: BaseModel<M>.Type,
                                   completionHandler: @escaping (NetworkResponse<M>) -> Void) -> DataRequest? {
        if !checkReachability() {
            return nil
        }
        self.isHttpRequestRun = true
        let url = initURL(method: method, type: type)
        print(url)
        let paramters = self.paramaters
        self.resetObject()
        let manager = AF
        manager.session.configuration.timeoutIntervalForRequest = 30
        manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        var request = URLRequest(url: URL(string: safeUrl(url: url))!)
        if json != nil {
            let paramString = String(data: json ?? Data(), encoding: String.Encoding.utf8)
            request.httpBody = paramString?.data(using: .utf8)
        } else {
            do {
                let data = try JSONSerialization.data(withJSONObject: paramters, options: [])
                let paramString = String(data: data, encoding: String.Encoding.utf8)
                request.httpBody = paramString?.data(using: .utf8)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        headers.append(.init(name: "Content-Type", value: "application/json"))
        request.httpMethod = type.rawValue
        request.allHTTPHeaderFields = header.dictionary
        request.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
        let alamofire = AF.request(request)
            .responseJSON { response in
                self.response(response: response, model, completionHandler: completionHandler)
            }
        return alamofire
    }
    // MARK: - ...  Advanced request for upload files & only file // type URL
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [URL], key: String,
                                      file: [String: URL?]? = nil, _ model: BaseModel<M>.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if !checkReachability() {
            return
        }
        self.isHttpRequestRun = true
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            files.forEach({ (item) in
                multipartFormData.append(item, withName: "\(key)[\(counter)]")
                counter += 1
            })
            if file != nil {
                file?.forEach({ (fileData) in
                    if let url = fileData.value {
                        multipartFormData.append(url, withName: "\(fileData.key)")
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: header)
        
        presentUploadProgress(upload: upload, model, completionHandler: completionHandler)
    }
    
    // MARK: - ...  Advanced request for upload files & only file // type UIImage
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [UIImage], key: String, file: [String: UIImage?]? = nil, _ model: BaseModel<M>.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if !checkReachability() {
            return
        }
        self.isHttpRequestRun = true
        let url = self.url+method
        let paramters = self.paramaters
        self.resetObject()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.jpegData(compressionQuality: 0.5) ?? Data(),
                                         withName: "\(key)[\(counter)]", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            if file != nil {
                file?.forEach({ (fileData) in
                    if let image = fileData.value {
                        multipartFormData.append(image.jpegData(compressionQuality: 0.5) ?? Data(),
                                                 withName: "\(fileData.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                        
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: header)
        
        presentUploadProgress(upload: upload, model, completionHandler: completionHandler)

    }
    // MARK: - ...  Advanced request for upload files & only file // type UIImage
    func uploadMultiFiles<M: Codable>(_ method: String , type: HTTPMethod, files: [String: UIImage]? = nil, file: [String: UIImage?]? = nil, _ model: BaseModel<M>.Type,
                                      completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        if !checkReachability() {
            return
        }
        self.isHttpRequestRun = true
        let url = self.url+method
            let paramters = self.paramaters
        self.resetObject()
        let upload = AF.upload(multipartFormData: { multipartFormData in
            var counter = 0
            for item in files ?? [:] {
                //multipartFormData.append(item, withName: "\(key)[\(counter)]")
                multipartFormData.append(item.value.jpegData(compressionQuality: 0.5) ?? Data(),
                                         withName: "\(item.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                counter += 1
            }
            if file != nil {
                file?.forEach({ (fileData) in
                    if let image = fileData.value {
                        multipartFormData.append(image.jpegData(compressionQuality: 0.5) ?? Data(),
                                                 withName: "\(fileData.key)", fileName: "\(String.random(ofLength: 15)).jpg", mimeType: "image/jpeg")
                        
                    }
                })
            }
            for (key, value) in paramters {
                if let id = value as? Int {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else if let id = value as? Double {
                    let string = id.string
                    multipartFormData.append(string.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                } else {
                    let string = value as? String
                    multipartFormData.append(string?.data(using: String.Encoding.utf8) ?? Data(), withName: key)
                }
            } //Optional for extra parameters
        },to: url, headers: header)
        
        presentUploadProgress(upload: upload, model, completionHandler: completionHandler)
    }
    
    func presentUploadProgress<M: Codable>(upload: UploadRequest, _ model: BaseModel<M>.Type, completionHandler: @escaping (NetworkResponse<M>) -> Void) {
        self.presenting()
        upload.uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
            self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            var progress = self.progressView.progress
            progress *= 100
            self.label.text = "\(Int(progress))"+"%"
        })
        upload.responseJSON { response in
            self.restore()
            self.isHttpRequestRun = false
            print(response.value ?? "")
            self.response(response: response, model, completionHandler: completionHandler)
        }
    }
}
