//
//  NetworkError.swift
//  BaseIOS
//
//  Created by R.Soliman on 10/13/20.
//  Copyright © 2020 coR.Soliman. All rights reserved.
//

import Foundation
// MARK: - ...  Network Response
struct NetworkError: LocalizedError {
    private let message: String
    var errors: [Errors]?
    init(message: String) {
        self.message = message
    }
    init(error: CustomError?) {
        self.message = error?.value ?? "Unexpected error."
    }
    init(errors: [Errors]?) {
        self.errors = errors
        self.message = "\(errors?.first?.value ?? "")"
    }
    var localizedDescription: String {
        return message.localized
    }
    var errorDescription: String? {
        return message.localized
    }
}

// MARK: - ...  Custom error
protocol CustomError: Error {
    var value: String { get }
}
extension CustomError where Self: RawRepresentable, Self.RawValue == String {
    var value: String {
        return rawValue
    }
}
