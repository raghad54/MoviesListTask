//
//  PresenterProtocol.swift
//  SupportI
//
//  Created by R.Soliman on 5/31/18.
//

import Foundation
import Alamofire
// MARK: - ...  Presenter Protocol
// All Presenters must implement this protocol
protocol PresenterProtocol {
    // Generic Type for any view
    associatedtype PresentingView
    var view: PresentingView? { get set }
    var requests: [DataRequest?] { get set }
    // methods for pagination
    func paginator(respnod: [Any]?)
    func canPaginate() -> Bool
    func resetPaginator()
    func removeTasks()

}
// MARK: - ...  Implement pagination functions
extension PresenterProtocol {
    // MARK: - ...  check array size
    func paginator(respnod: [Any]?) {
        NetworkManager.instance.checkPaginator(respond: respnod)
    }
    // MARK: - ...  Check make another call for pagination
    func canPaginate() -> Bool {
        if !NetworkManager.instance.isHttpRequestRun && !NetworkManager.instance.paginatorStop {
            NetworkManager.instance.incresePaginate()
            return true
        } else {
            return false
        }
    }
    // MARK: - ...  Reset pagination Data
    func resetPaginator() {
        NetworkManager.instance.resetPaginate()
    }
}
