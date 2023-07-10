//
//  MoviesListVC.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MoviesListVC: BaseController, MoviesListViewContract {
  
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
    
    private var moviesListArray =  [Result?]()
    private var paginationCounter: Int = 1
    private var refreshControl = UIRefreshControl()
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
        setupRefreshPage()
        presenter?.getMoviesList(page: 1)
        moviesListArray.removeAll()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
    
    private func setupView() {
        setUpNib()
        setupNavigation()
        setupTableView()
    }
    
    private func setUpNib() {
        moviesListTableView.register(UINib(nibName: R.nib.moviesListTableCell.name, bundle: nil), forCellReuseIdentifier: MoviesListTableCell.ID)
    }
    private func setupNavigation() {
        navigation.delegate = self
        navigation.bind(titleLabel: "Movies List", isBackHidden: true)
    }
    
    private func setupTableView() {
        let spinner = UIActivityIndicatorView(style: .large)
          spinner.startAnimating()
          moviesListTableView.backgroundView = spinner
    }
    
    private func handleIndicatorWhenLoadingMoreData() {
        let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: moviesListTableView.bounds.width, height: CGFloat(44))
            self.moviesListTableView.tableFooterView = spinner
            self.moviesListTableView.tableFooterView?.isHidden = false
    }
    
    private func setupRefreshPage() {
        refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            moviesListTableView.refreshControl = refreshControl
        } else {
            moviesListTableView.addSubview(refreshControl)
        }
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        self.moviesListArray.removeAll()
        presenter?.getMoviesList(page: 1)
    }
    
}
// MARK: - ...  Functions
extension MoviesListVC: NavigationBarDelegate {
    func backAction() {
    }
}

extension MoviesListVC {
    func moviesListFetched(model: MoviesListModel?) {
        self.refreshControl.endRefreshing()
        self.moviesListArray.append(contentsOf: model!.results)
        self.moviesListTableView.reloadData()
    }
    
    func didFail(message: String) {
        makeAlert(message, closure: {})
    }
}

extension MoviesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesListTableView.dequeueReusableCell(withIdentifier: MoviesListTableCell.ID) as! MoviesListTableCell
        cell.config(result: moviesListArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = self.moviesListArray.count - 1
              if indexPath.row == lastIndex {
                  handleIndicatorWhenLoadingMoreData()
                  paginationCounter += 1
                  self.presenter?.getMoviesList(page: paginationCounter)
              }
          }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.pushToMovieDetails(movieId: moviesListArray[indexPath.row]?.id ?? 0)
    }
}
