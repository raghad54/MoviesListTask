//
//  MoviesListPresenter.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Presenter
class MoviesListPresenter: BasePresenter<MoviesListViewContract> {
}
// MARK: - ...  Presenter Contract
extension MoviesListPresenter: MoviesListPresenterContract {
    func getMoviesList(page: Int) {
        NetworkManager.instance.request("https://api.themoviedb.org/3/discover/movie?api_key=c9856d0cb57c3f14bf75bdc6c063b8f3&page=\(page)", type: .get, MoviesListModel.self) { (response) in
            switch response {
            case .success(let model):
                self.view?.moviesListFetched(model: model)
            case .failure(let error):
                self.view?.didFail(message: error?.localizedDescription ?? "")
            }
          }
    }
    
}

