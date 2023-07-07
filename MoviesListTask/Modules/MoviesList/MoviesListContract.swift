//
//  MoviesListContract.swift
//  BaseIOS
//
//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol MoviesListPresenterContract: PresenterProtocol {
    func getMoviesList(page: Int)
}
// MARK: - ...  View Contract
protocol MoviesListViewContract: PresentingViewProtocol {
    func moviesListFetched(model:MoviesListModel?)
    func didFail(message: String)
}
// MARK: - ...  Router Contract
protocol MoviesListRouterContract: Router, RouterProtocol {
}
