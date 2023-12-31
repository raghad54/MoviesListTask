//
//  MoviesListTableCell.swift

//
//  Created by Raghad Ali on 07/07/2023.
//

import UIKit
import Kingfisher

class MoviesListTableCell: UITableViewCell {

    static let ID = "MoviesListTableCell"
    static let nib = UINib(nibName: R.nib.moviesListTableCell.name, bundle: nil)
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieProductionHistoryOfTheFilmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        movieImageView.layer.cornerRadius = 20
        movieImageView.addTopShadow()
    }

    func config(result: Result?) {
        self.movieNameLabel.text = result?.title
        self.movieProductionHistoryOfTheFilmLabel.text = result?.releaseDate
        
        movieImageView.kf.indicatorType = .activity
        let url = URL(string: "http://image.tmdb.org/t/p/w500/\(result?.backdropPath ?? "")")
        movieImageView.kf.setImage(with: url)
    }
}
