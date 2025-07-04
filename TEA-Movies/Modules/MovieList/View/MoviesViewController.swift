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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if moviesViewModel.checkInternetConnection() {
            moviesViewModel.getMovies(sortedBy: .descending, releaseYear: 2025)
        } else {
            moviesViewModel.getLocalMovies()
        }
    }
    
    private func bindValues() {
        moviesViewModel.bindMovies = { [weak self] in
            self?.movies = self?.moviesViewModel.moviesResponse?.results ?? []
            self?.checkFave()
            self?.moviesTableView.reloadData()
            if ((self?.moviesViewModel.checkInternetConnection()) ?? false) {
                self?.moviesViewModel.clearLocalDB()
            }
        }
    }
    
    private func checkFave() {
       let faveMovies = moviesViewModel.getFavedMovies()
        let faveIDs = Set(faveMovies.map { $0.id })

        for i in 0..<movies.count {
            movies[i].isFave = faveIDs.contains(movies[i].id)
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
        cell?.addNewMovie(movies[indexPath.row])
        cell?.indexPath = indexPath
        cell?.dealingWithMovieDelegate = self
        return cell ?? UITableViewCell()
    }
    
    
}

extension MoviesViewController: DealingWithMovieDelegate {
    func toggleMovieToFavourite(at indexPath: IndexPath, add: Bool) {
        moviesViewModel.changeMovieFave(movie: movies[indexPath.row], isfave: add)
        print(add)
    }
}
