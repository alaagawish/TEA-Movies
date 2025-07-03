//
//  MovieTableViewCell.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 03/07/2025.
//

import UIKit
import Cosmos
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var faveButton: UIButton!
    @IBOutlet private weak var movieDate: UILabel!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    var indexPath: IndexPath!
    var dealingWithMovieDelegate: DealingWithMovieDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func addNewMovie(_ movie: MoviesResponseResults, isFave: Bool) {
        movieImage.kf.setImage(with: URL(string: movie.posterPath ?? ""), placeholder: UIImage(named: "notfound"))
        ratingView.rating = Double(movie.voteAverage ?? 0) / 2.0
        ratingView.isUserInteractionEnabled = false
        movieName.text = movie.title
        movieDate.text = movie.releaseDate
        faveButton.setImage(UIImage(systemName: isFave ? Constants.filledStar : Constants.star), for: .normal)
        
    }
    
    @IBAction func addToFavourite(_ sender: Any) {
        if faveButton.image(for: .normal) == UIImage(systemName: Constants.star) {
            dealingWithMovieDelegate.toggleMovieToFavourite(at: indexPath, add: true)
            faveButton.setImage(UIImage(systemName: Constants.filledStar), for: .normal)
        } else {
            dealingWithMovieDelegate.toggleMovieToFavourite(at: indexPath, add: false)
            faveButton.setImage(UIImage(systemName: Constants.star), for: .normal)
        }
    }
}

protocol DealingWithMovieDelegate {
    func toggleMovieToFavourite(at indexPath: IndexPath, add: Bool)
}
