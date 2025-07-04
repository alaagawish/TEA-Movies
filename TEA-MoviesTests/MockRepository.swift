//
//  MockRepository.swift
//  TEA-MoviesTests
//
//  Created by Alaa Gawish on 04/07/2025.
//

import Foundation
@testable import TEA_Movies

class MockRepository: RepositoryProtocol {
    
    var moviesToReturn: [MoviesResponseResults] = []
    var moviesResponseToReturn: MoviesResponse?
    var isConnected = true
    var clearAllCalled = false
    var changedFaveMovie: (movie: MoviesResponseResults, isFave: Bool)?
    
    func startMonitoring() {
        isConnected = true
    }
    
    func waitUntilChecked(completion: @escaping (Bool) -> Void) {
        completion(isConnected)
    }
    
    func getMoviesList(sortedBy: TEA_Movies.SortTypes, releaseYear: Int, token: String, completion: @escaping (TEA_Movies.MoviesResponse?) -> Void) {
        if let response = moviesResponseToReturn {
            completion(response)
        }
    }
    func getMovies() -> [MoviesResponseResults] {
        return moviesToReturn
    }
    
    func clearAllMovies() {
        clearAllCalled = true
    }
    
    func add(movies: [MoviesResponseResults]) {
      
    }
    
    func isConnectedToInternet() -> Bool {
        return isConnected
    }
    
    func changeFaveOfMovie(movie: MoviesResponseResults, isFave: Bool) {
        changedFaveMovie = (movie, isFave)
    }
}
