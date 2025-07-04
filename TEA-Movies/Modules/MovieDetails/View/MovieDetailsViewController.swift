//
//  MovieDetailsViewController.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import UIKit
import Cosmos

class MovieDetailsViewController: UIViewController {
    static let identifier = "MovieDetailsViewController"
    @IBOutlet private weak var movieOriginalLanguage: UILabel!
    @IBOutlet private weak var movieVote: UILabel!
    @IBOutlet private weak var movieDetails: UILabel!
    @IBOutlet private weak var movieRate: CosmosView!
    @IBOutlet private weak var movieDate: UILabel!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var faveButton: UIButton!
    
    var movie: MoviesResponseResults!
    var moviesViewModel: MoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel = MoviesViewModel(repository: Repository(network: Network(), localDataStore: LocalLayer()))
        setValues()
        
    }
    
    private func setValues() {
        faveButton.setImage(UIImage(systemName: movie.isFave ?? false ? Constants.filledStar : Constants.star), for: .normal)
        movieName.text = movie.originalTitle
        movieDate.text = movie.releaseDate
        movieDetails.text = movie.overview
        movieVote.text = "Average Vote: \(movie.voteAverage ?? 0)"
        movieRate.isUserInteractionEnabled = false
        movieRate.rating = Double(movie.voteAverage ?? 0) / 2
        movieImage.kf.setImage(with: URL(string: "\(Constants.IMAGE_BASE_URL)\(movie.posterPath ?? "")"), placeholder: UIImage(named: "notfound"))
        movieOriginalLanguage.text = "Original Language: \(movie.originalLanguage?.uppercased() ?? "not found")"
    }
    @IBAction func addItemToFave(_ sender: Any) {
        if faveButton.image(for: .normal) == UIImage(systemName: Constants.star) {
            moviesViewModel.changeMovieFave(movie: movie, isfave: true)
            faveButton.setImage(UIImage(systemName: Constants.filledStar), for: .normal)
        } else {
            moviesViewModel.changeMovieFave(movie: movie, isfave: false)
            faveButton.setImage(UIImage(systemName: Constants.star), for: .normal)
        }
    }
}
