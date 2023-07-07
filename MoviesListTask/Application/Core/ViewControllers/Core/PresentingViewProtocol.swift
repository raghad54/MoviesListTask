//
//  CorePresentingViewModel.swift
//  SupportI
//
//  Created by R.Soliman on 5/31/18.


import Foundation
import UIKit

// All ViewControllers must implement this protocol
protocol PresentingViewProtocol: NSObjectProtocol {
    func startLoading()
    func stopLoading()
   // func didError(error: String?)
}

// implementation of PresentingViewProtocol only in cases where the presenting view is a UIViewController
extension PresentingViewProtocol where Self: BaseController {
}
