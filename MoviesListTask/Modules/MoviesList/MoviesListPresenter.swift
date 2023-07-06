//
//  MoviesListPresenter.swift
//  BaseIOS
//
//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Presenter
class MoviesListPresenter: BasePresenter<MoviesListViewContract> {
}
// MARK: - ...  Presenter Contract
extension MoviesListPresenter: MoviesListPresenterContract {
}
// MARK: - ...  Example of network response
extension MoviesListPresenter {
    func fetchResponse<T: MoviesListModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
