//
//
//

import CoreData

// MARK: - ...  Base Model for all models
class BaseModel<T: Codable>: Codable {
    var success: Bool?
    var message: String?
    var errors: [Errors]?
    var data: T?
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case errors
        case data
    }
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        message = try? container?.decode(String.self, forKey: .message)
        success = try? container?.decode(Bool.self, forKey: .success)
        errors = try? container?.decode([Errors].self, forKey: .errors)
        data = try? container?.decode(T.self, forKey: .data)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(message, forKey: .message)
        try? container.encode(success, forKey: .success)
        try? container.encode(errors, forKey: .errors)
        try? container.encode(data, forKey: .data)
    }
    func description() -> String {
        let str: NSMutableString = NSMutableString()
        for error in errors ?? [] {
            str.append("\(error.key ?? "") : \(error.value ?? error.message ?? "") ")
            break
        }
        //print("desc=\(str)")
        return str as String
    }
}
