//
//  POPUPViewController.swift
//
//  Created by R.Soliman on 6/2/18.
//

import Foundation
import UIKit
// MARK: - ...  Protocol to open view as a pop up view
protocol POPUPModal {
    func pushPop(_ scene: UIViewController)
}
// MARK: - ...  Protocol to open view as a pop up view
extension POPUPModal where Self: BaseController {
    func pushPop(_ scene: UIViewController) {
        scene.modalPresentationStyle = .overFullScreen
        scene.view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        let topVC = UIApplication.topMostController()
        topVC.present(scene, animated: true, completion: nil)
    }
}
// MARK: - ...  Protocol to open view as a pop up view
extension BaseController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
