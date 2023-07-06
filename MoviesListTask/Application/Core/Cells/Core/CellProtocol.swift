//
//  UICollectionViewProtocol.swift
//
//  Created by R.Soliman on 6/4/18.
//

import Foundation
import UIKit

// MARK: - ...  Cell Error
public enum CellError: Error {
    case confirmProtocol
}
// MARK: - ...  Cell Protocol Must all cells implement this protocol
public protocol CellProtocol {
    func setup()
}
