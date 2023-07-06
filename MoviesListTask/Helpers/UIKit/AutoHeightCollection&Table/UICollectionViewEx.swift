//
//  UICollectionViewEx.swift
//  BookistaProvider
//
//  Created by R.Soliman on 22/04/2021.

//

import Foundation
import UIKit

extension UICollectionView {
//    func autoHeight() {
//        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
//            constraint.constant = self.collectionViewLayout.collectionViewContentSize.height
//        }
//    }
    func autoHeight(for view: UIView? = nil) {
        if let constraint = self.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = self.collectionViewLayout.collectionViewContentSize.height
            if view != nil && constraint.constant < (view?.height ?? 0) - 350 {
                constraint.constant = (view?.height ?? 0) - 350
            }
        }
    }
}
