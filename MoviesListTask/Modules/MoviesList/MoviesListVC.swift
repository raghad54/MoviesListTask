//
//  MoviesListVC.swift
//  BaseIOS
//
//  Created by Raghad Ali on 06/07/2023.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MoviesListVC: BaseController, MoviesListViewContract {
  
    var presenter: MoviesListPresenter?
    var router: MoviesListRouter?
}

// MARK: - ...  LifeCycle
extension MoviesListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension MoviesListVC {
    func setup() {
    }
    
    func didError(error: String?) {

    }
    
}

