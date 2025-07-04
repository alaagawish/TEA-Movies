//
//  Network.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation
import Alamofire

class Network: NetworkProtocol {
    func getMoviesList(sortedBy: SortTypes, releaseYear: Int, token: String, completion: @escaping (MoviesResponse?) -> Void) {
        
        NetworkManager.shared.getRequest(url: "3/discover/movie?primary_release_year=\(releaseYear)&sort_by=vote_average.\(sortedBy.rawValue)", token: Constants.TOKEN, responseType: MoviesResponse.self, handler: completion)
    }
    
}
