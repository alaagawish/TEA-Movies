//
//  Repository.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 02/07/2025.
//

import Foundation

class Repository: NetworkProtocol {
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
        print("internet check \(Connectivity.shared.isConnected)")
        return Connectivity.shared.isConnected
    }
}
