//
//  EmptyScreenContract.swift
//  geoshield
//
//  Created by R.Soliman on 08/04/2021.

//

import Foundation
import UIKit
protocol NetworkFailScreenContract: AnyObject {
    
}

extension NetworkFailScreenContract where Self: BaseController {
    func showNetworkFailScreen(for top: CGFloat = 0) {
        hideNetworkFailScreen()
        networkScreen = NetworkFailScreen()
        networkScreen.container.backgroundColor = self.view.backgroundColor
        self.view.addSubview(networkScreen)
        networkScreen.addTopConstraint(toView: view, constant: top)
        networkScreen.addLeadingConstraint(toView: view)
        networkScreen.addTrailingConstraint(toView: view)
        networkScreen.addBottomConstraint(toView: view, constant: 0)
    }
    func hideNetworkFailScreen() {
        if networkScreen != nil && networkScreen.superview != nil {
            networkScreen.removeFromSuperview()
        }
    }
}
