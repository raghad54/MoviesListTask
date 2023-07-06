//
//  EmptyScreenContract.swift
//  geoshield
//
//  Created by R.Soliman on 08/04/2021.

//

import Foundation
import UIKit
protocol EmptyScreenContract: AnyObject {
    
}

extension EmptyScreenContract where Self: BaseController {
    func showEmptyScreen(for top: CGFloat = 140, for bottom: CGFloat = 0, title: String? = "Empty screen", body: String? = "This page is blank and has no content So now please browse the another page") {
        hideEmptyScreen()
        emptyScreen = EmptyScreen()
        emptyScreen.titleLbl.text = title?.localized
        emptyScreen.bodyLbl.text = body?.localized
        emptyScreen.container.backgroundColor = self.view.backgroundColor
        self.view.addSubview(emptyScreen)
        emptyScreen.addTopConstraint(toView: view, constant: top)
        emptyScreen.addLeadingConstraint(toView: view)
        emptyScreen.addTrailingConstraint(toView: view)
        emptyScreen.addBottomConstraint(toView: view, constant: bottom)
    }
    func hideEmptyScreen() {
        if emptyScreen != nil && emptyScreen.superview != nil {
            emptyScreen.removeFromSuperview()
        }
    }
}
