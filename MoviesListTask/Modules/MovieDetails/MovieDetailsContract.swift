//
//  MovieDetailsContract.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol MovieDetailsPresenterContract: PresenterProtocol {
    func getMovieDetails(movieId:Int)
}
// MARK: - ...  View Contract
protocol MovieDetailsViewContract: PresentingViewProtocol {
    func movieDetailsFetched(model:MovieDetailsModel?)
    func didFail(message: String)
}
// MARK: - ...  Router Contract
protocol MovieDetailsRouterContract: Router, RouterProtocol {
    func backButtonTapped()
}
