//
//  NetworkProtocol.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation

protocol NetworkProtocol {
    func getMoviesList(sortedBy: SortTypes, releaseYear: Int, token: String, completion: @escaping (MoviesResponse?) -> Void)
}
