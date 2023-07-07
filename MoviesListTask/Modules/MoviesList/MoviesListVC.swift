//
//  MoviesListVC.swift
//  BaseIOS
//
//  Created by Raghad Ali on 06/07/2023.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MoviesListVC: BaseController, MoviesListViewContract, NavigationBarWithTitleDelegate {
  
    var presenter: MoviesListPresenter?
    var router: MoviesListRouter?
    
    static func create() -> MoviesListVC {
        let viewController = R.storyboard.moviesListStoryboard.moviesListVC()!
        return viewController
    }
    
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var moviesListTableView: UITableView!{
            didSet {
                moviesListTableView.dataSource = self
                moviesListTableView.delegate = self
            }
    }
    
    private var moviesListArray : MoviesListModel?
}

// MARK: - ...  LifeCycle
extension MoviesListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        startLoading()
        presenter?.getMoviesList(page: 1)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
    
    private func setupView() {
        setUpNib()
        setupNavigation()
    }
    
    private func setUpNib() {
        moviesListTableView.register(UINib(nibName: R.nib.moviesListTableCell.name, bundle: nil), forCellReuseIdentifier: MoviesListTableCell.ID)
    }
    func setupNavigation() {
        navigation.delegate = self
        navigation.bind(titleLabel: "Movies List", isBackHidden: true)
    }
}
// MARK: - ...  Functions
extension MoviesListVC {
    func setup() {
    }
    
    func backAction() {
        
    }
    
}

extension MoviesListVC {
    func moviesListFetched(model: MoviesListModel?) {
        self.moviesListArray = model
        self.moviesListTableView.reloadData()
    }
    
    func didFail(message: String) {
    
    }
    
}

extension MoviesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListArray?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesListTableView.dequeueReusableCell(withIdentifier: MoviesListTableCell.ID) as! MoviesListTableCell
        cell.config(result: moviesListArray?.results[indexPath.row])
        
        return cell
    }
    
    
}
