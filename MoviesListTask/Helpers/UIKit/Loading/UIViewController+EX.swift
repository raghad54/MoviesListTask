//
//  UIViewController+EX.swift

//
//  Created by R.Soliman on 01/06/2021.

//

import Foundation
import UIKit

extension UIViewController {
    func startLoading() {

    }
    func stopLoading() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.view.isUserInteractionEnabled = true
        }
    }
}
