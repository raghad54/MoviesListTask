//
//  MoviesListTableCell.swift
//  BaseIOS
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func config(result: Result?) {
        self.movieNameLabel.text = result?.title
        self.movieProductionHistoryOfTheFilmLabel.text = result?.releaseDate
        let url = URL(string: "http://image.tmdb.org/t/p/w500/\(result?.backdropPath ?? "")")
        movieImageView.kf.setImage(with: url)
    }

}
