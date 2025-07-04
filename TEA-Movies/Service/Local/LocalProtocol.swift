//
//  LocalProtocol.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation

protocol LocalProtocol {
    func add(movies: [MoviesResponseResults])
    func changeFaveOfMovie(movie: MoviesResponseResults, isFave: Bool)
    func getMovies() -> [MoviesResponseResults]
    func clearAllMovies()
    
}
