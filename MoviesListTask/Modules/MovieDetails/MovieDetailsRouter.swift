//
//  MovieDetailsRouter.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation

// MARK: - ...  Router
class MovieDetailsRouter: Router {
    typealias PresentingView = MovieDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MovieDetailsRouter: MovieDetailsRouterContract {
    
}
