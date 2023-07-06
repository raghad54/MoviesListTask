//
//  Alertable.swift
//  SupportI
//
//  Created by R.Soliman on 7/30/19.
//  Copyright © 2019 R.Soliman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Alertable protocol for alert messages
protocol Alertable: AnyObject {
    func makeAlert(_ message: String, noCancel: Bool?, closure: @escaping () -> Void )
    static func authAlert()
    func createActionSheet(title: String, actions: [String: Any], closure: @escaping ([String: Any]) -> Void )
}

extension Alertable {
    func makeAlert(_ message: String, noCancel: Bool? = nil, closure: @escaping () -> Void ) {
        let alert = UIAlertController(title: "Alert".localized, message: message, preferredStyle: UIAlertController.Style.alert)
        let acceptAction = UIAlertAction(title: "Ok".localized, style: .default) { (_) -> Void in
            closure()
        }
        alert.addAction(acceptAction)
        if noCancel == nil {
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default) { (_) -> Void in
            }
            alert.addAction(cancelAction)
        }
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    public static func authAlert() {
        let alert = UIAlertController(title: "Alert".localized, message: "You must be logged in".localized,
                                      preferredStyle: UIAlertController.Style.alert)
        let acceptAction = UIAlertAction(title: "Ok".localized, style: .default) { (_) -> Void in
            Router.instance.unAuthorized()
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default) { (_) -> Void in
        }
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    func createActionSheet(title: String, actions: [String: Any], closure: @escaping ([String: Any]) -> Void ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for (key, value) in actions {
            alert.addAction(UIAlertAction(title: key, style: .default, handler: { _ in
                closure([key: value])
            }))
        }
        alert.addAction(UIAlertAction.init(title: "Cancel".localized, style: .cancel, handler: nil))
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.permittedArrowDirections = .up
            alert.popoverPresentationController?.sourceView = UIApplication.topMostController().view
        default:
            break
        }
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
