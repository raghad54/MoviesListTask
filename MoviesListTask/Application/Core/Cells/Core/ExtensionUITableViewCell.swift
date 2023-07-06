//
//  ExtensionUITableViewCell.swift
//
//  Created by R.Soliman on 6/21/18.
//

import Foundation
import UIKit

extension UITableView {
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
            self.register(UINib(nibName: ind, bundle: nil), forCellReuseIdentifier: ind)
        }
        let cellProt = self.dequeueReusableCell(withIdentifier: ind, for: indexPath) as? T
        if cellProt is CellProtocol {
            let cell = cellProt as? CellProtocol
            //cell?.path = indexPath.item
            if let cell = cell as? T {
                return cell
            } else {
                return cellProt!
            }
        } else {
            return cellProt!
        }

    }
}
