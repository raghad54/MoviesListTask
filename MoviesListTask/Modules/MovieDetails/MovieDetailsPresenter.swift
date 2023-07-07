//
//  MovieDetailsPresenter.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Presenter
class MovieDetailsPresenter: BasePresenter<MovieDetailsViewContract> {
}
// MARK: - ...  Presenter Contract
extension MovieDetailsPresenter: MovieDetailsPresenterContract {
}
// MARK: - ...  Example of network response
extension MovieDetailsPresenter {
    func fetchResponse<T: MovieDetailsModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
