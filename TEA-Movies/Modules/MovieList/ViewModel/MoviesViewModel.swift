//
//  MoviesViewModel.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation

class MoviesViewModel {
    let repository: Repository!
    init(repository: Repository!) {
        self.repository = repository
    }
    var bindMovies: (()->()) = {}
    var bindLocalMovies: (()->()) = {}
    var bindFaveMovies: (()->()) = {}
    var localMovies: [MoviesResponseResults]? {
        didSet {
            bindLocalMovies()
        }
    }
    var faveMovies: [MoviesResponseResults]? {
        didSet {
            bindFaveMovies()
        }
    }
    var moviesResponse: MoviesResponse? {
        didSet {
            bindMovies()
        }
    }
    
    func getMovies(sortedBy: SortTypes, releaseYear: Int) {
        repository.getMoviesList(sortedBy: sortedBy, releaseYear: releaseYear, token: Constants.TOKEN) { [weak self] result in
            self?.moviesResponse = result
        }
    }
    
    func getLocalMovies() {
        localMovies = repository.getMovies()
    }
    
    func getFavedMovies() -> [MoviesResponseResults] {
        return repository.getMovies().filter { $0.isFave == true }
    }
    
    func clearLocalDB() {
        repository.clearAllMovies()
        saveMovieToLocalDB()
    }
    
    func saveMovieToLocalDB() {
        repository.add(movies: moviesResponse?.results ?? [])
    }
    func checkInternetConnection() -> Bool {
        return repository.isConnectedToInternet()
    }
    func changeMovieFave(movie: MoviesResponseResults, isfave: Bool) {
        repository.changeFaveOfMovie(movie: movie, isFave: isfave)
        self.getLocalMovies()
    }
}
