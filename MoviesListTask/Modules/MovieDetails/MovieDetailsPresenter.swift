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
    func getMovieDetails(movieId: Int) {
        NetworkManager.instance.request("https://api.themoviedb.org/3/movie/\(movieId)?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3", type: .get, MovieDetailsModel.self) { (response) in
            switch response {
            case .success(let model):
                self.view?.movieDetailsFetched(model: model)
            case .failure(let error):
                self.view?.didFail(message: error?.localizedDescription ?? "")
            }
          }
    }
    
}
