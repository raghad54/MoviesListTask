//
//  MoviesListRouter.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Router
class MoviesListRouter: Router {
    typealias PresentingView = MoviesListVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MoviesListRouter: MoviesListRouterContract {
    func pushToMovieDetails(movieId: Int) {
        view?.push(MovieDetailsVC.create(movieId: movieId))
    }
    
    
}
