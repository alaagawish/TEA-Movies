//
//  Repository.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation

class Repository: NetworkProtocol, LocalProtocol {
    
    var network: NetworkProtocol!
    var localDataStore: LocalProtocol!
    init(network: NetworkProtocol!, localDataStore: LocalProtocol!) {
        startMonitoring()
        self.network = network
        self.localDataStore = localDataStore
    }
    func getMoviesList(sortedBy: SortTypes, releaseYear: Int, token: String, completion: @escaping (MoviesResponse?) -> Void) {
        self.network.getMoviesList(sortedBy: sortedBy, releaseYear: releaseYear, token: token, completion: completion)
    }
    func startMonitoring() {
        Connectivity.shared.startMonitoring()
    }
    func isConnectedToInternet() -> Bool {
        return Connectivity.shared.isConnected
    }
    
    func add(movies: [MoviesResponseResults]) {
        localDataStore.add(movies: movies)
    }
    
    func changeFaveOfMovie(movie: MoviesResponseResults, isFave: Bool) {
        localDataStore.changeFaveOfMovie(movie: movie, isFave: isFave)
    }
    
    func getMovies() -> [MoviesResponseResults] {
        return localDataStore.getMovies()
    }
    
    func clearAllMovies() {
        localDataStore.clearAllMovies()
    }
    
}
