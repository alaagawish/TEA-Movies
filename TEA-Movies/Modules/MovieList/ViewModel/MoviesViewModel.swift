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
    
    var moviesResponse: MoviesResponse? {
        didSet {
            bindMovies()
        }
    }
    
    func getMovies(sortedBy: SortTypes, releaseYear: Int) {
        repository.getMoviesList(sortedBy: sortedBy, releaseYear: releaseYear, token: Constants.TOKEN) { [weak self] result in
            self?.moviesResponse = result
            self?.clearLocalDB()
          
        }
    }
    
    func getLocalMovies() {
        
    }
    
    func clearLocalDB() {
//        self?.saveMovieToLocalDB()
    }
    
    func saveMovieToLocalDB() {
        
    }
    func checkInternetConnection() -> Bool {
       return repository.isConnectedToInternet()
    }
}
