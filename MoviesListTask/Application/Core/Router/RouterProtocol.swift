//
//  RouterProtocol.swift
//  BaseIOS
//
//  Created by R.Soliman on 10/18/20.

import Foundation
// MARK: - ...  Router Protocol
// All Router must implement this protocol
protocol RouterProtocol {
    // Generic Type for any view
    associatedtype PresentingView
    var view: PresentingView? { get set }
}
