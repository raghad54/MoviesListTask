//
//  MovieDetailsVC.swift

//  Created by Raghad Ali on 06/07/2023.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - ...  ViewController - Vars
class MovieDetailsVC: BaseController {
    var presenter: MovieDetailsPresenter?
    var router: MovieDetailsRouter?
    
    static func create(movieId:Int) -> MovieDetailsVC {
        let viewController = R.storyboard.movieDetailsStoryboard.movieDetailsVC()!
        viewController.movieId = movieId
        return viewController
    }
    
    @IBOutlet weak var navigation: NavigationBar!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieProductionHistoryOfTheFilmLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var dynamicTextViewHeight: NSLayoutConstraint!

    
    private var movieId: Int?
}

// MARK: - ...  LifeCycle
extension MovieDetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideNav = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        presenter?.getMovieDetails(movieId: movieId ?? 0)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
    
    private func setupView() {
        setupNavigation()
        movieImageView.layer.cornerRadius = 20
        movieDescriptionTextView.delegate = self
       
    }
    
    private func setupNavigation() {
        navigation.delegate = self
        navigation.bind(titleLabel: "Movie Details", isBackHidden: false)
    }
}
// MARK: - ...  Functions
extension MovieDetailsVC: NavigationBarDelegate {
    func backAction() {
      router?.backButtonTapped()
    }
}
// MARK: - ...  View Contract
extension MovieDetailsVC: MovieDetailsViewContract {
    func movieDetailsFetched(model: MovieDetailsModel?) {
        movieImageView.kf.indicatorType = .activity
        let url = URL(string: "http://image.tmdb.org/t/p/w500/\(model?.backdropPath ?? "")")
        movieImageView.kf.setImage(with: url)
        self.movieNameLabel.text = model?.title
        self.movieProductionHistoryOfTheFilmLabel.text = model?.releaseDate
        self.movieDescriptionTextView.text = model?.overview
    }
    
    func didFail(message: String) {
        makeAlert(message, closure: {})
    }
    
}

extension MovieDetailsVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
       self.dynamicTextViewHeight.constant = movieDescriptionTextView.contentSize.height
       self.view.layoutIfNeeded()
    }
}

