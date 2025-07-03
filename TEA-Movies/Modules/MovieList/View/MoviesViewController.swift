//
//  MoviesViewController.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var moviesTableView: UITableView!
    
    var movies: [MoviesResponseResults] = []
    var moviesViewModel: MoviesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel = MoviesViewModel(repository: Repository(network: Network(), localDataStore: LocalLayer()))
        registerCell()
        bindValues()
        // TODO: - CHECK INTERNET CONNECTION
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesViewModel.getMovies(sortedBy: .descending, releaseYear: 2025)
    }
    private func bindValues() {
        moviesViewModel.bindMovies = { [weak self] in
            self?.movies = self?.moviesViewModel.moviesResponse?.results ?? []
            self?.moviesTableView.reloadData()
        }
    }
    private func registerCell() {
        moviesTableView.register(UINib(nibName: MovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    
    
}
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell
        // TODO: - CHECK IS FAVE?
        cell?.addNewMovie(movies[indexPath.row], isFave: false)
        cell?.indexPath = indexPath
        cell?.dealingWithMovieDelegate = self
        return cell ?? UITableViewCell()
    }
    
    
}

extension MoviesViewController: DealingWithMovieDelegate {
    func toggleMovieToFavourite(at indexPath: IndexPath, add: Bool) {
        if add {
            
        } else {
            
        }
        moviesViewModel.getMovies(sortedBy: .descending, releaseYear: 2025)
    }
    
    
}
