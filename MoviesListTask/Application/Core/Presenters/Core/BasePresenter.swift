//
//  CoreViewModel.swift
//  SupportI
//
//  Created by R.Soliman on 5/31/18.
//

import Foundation
import Alamofire
// MARK: - ...  Base Presenter
class BasePresenter<T>: NSObject, PresenterProtocol {
    var requests: [DataRequest?] = []
    typealias PresentingView = T
    private var _view: PresentingView?
    var view: PresentingView? {
        set {
            _view = newValue
        } get {
            return _view
        }
    }
    // MARK: - ...  empty the refrence 
    deinit {
        removeTasks()
        view = nil
    }
}

extension BasePresenter {
    func removeTasks() {
        requests.forEach { (request) in
            request?.task?.cancel()
        }
    }
}
