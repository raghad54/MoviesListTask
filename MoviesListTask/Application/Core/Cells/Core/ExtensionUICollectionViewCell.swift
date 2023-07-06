//
//  ExtensionUITableViewCell.swift
//
//  Created by R.Soliman on 6/21/18.
//

import Foundation
import UIKit

extension UICollectionView {
    /// func cell Template
    ///
    /// - Parameters:
    ///   - cell: Template
    ///   - indexPath: indexpath
    ///   - register: register
    /// - Returns: return the template cell
    func cell<T>(type: T.Type, _ indexPath: IndexPath, register: Bool = true) -> T {
        let ind = String(describing: type)
        if register {
            self.register(UINib(nibName: ind, bundle: nil), forCellWithReuseIdentifier: ind)
        }
        let cellProtcol = self.dequeueReusableCell(withReuseIdentifier: ind, for: indexPath) as? T
        if let cell = cellProtcol as? CellProtocol {
            //cell.path = indexPath.item
            if let cell = cell as? T {
                return cell
            } else {
                return cellProtcol!
            }
        } else {
            return cellProtcol!
        }
    }

}
