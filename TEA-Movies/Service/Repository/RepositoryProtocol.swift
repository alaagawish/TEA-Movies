//
//  RepositoryProtocol.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 04/07/2025.
//

import Foundation

protocol RepositoryProtocol: NetworkProtocol, LocalProtocol, ConnectivityProtocol {
    func isConnectedToInternet() -> Bool
}
