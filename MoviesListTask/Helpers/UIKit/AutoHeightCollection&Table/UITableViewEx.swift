//
//  UITableViewEx.swift
//  BookistaProvider
//
//  Created by R.Soliman on 22/04/2021.

//

import Foundation
import UIKit

extension UITableView {
    func autoHeight(for view: UIView? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
                constraint.constant = self.contentSize.height
                if view != nil && constraint.constant < (view?.height ?? 0) - 350 {
                    constraint.constant = (view?.height ?? 0) - 350
                } else {
                    if constraint.constant >= UIScreen.main.bounds.height - 150 {
                        constraint.constant = UIScreen.main.bounds.height - 160
                    }
                }
                
            }
        }
    }

    
    func setHeight(for height: CGFloat = 200) {
        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = height
        }
    }
}
