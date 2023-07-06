//
//  NetworkResponse.swift
//  BaseIOS
//
//  Created by R.Soliman on 10/13/20.
//  Copyright © 2020 coR.Soliman. All rights reserved.
//

import Foundation
// MARK: - ...  Network Response
enum NetworkResponse<T: Codable> {
    case success(T?)
    case failure(Error?)
}
