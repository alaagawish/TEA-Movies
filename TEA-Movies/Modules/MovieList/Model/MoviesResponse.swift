//
//  MoviesResponse.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 03/07/2025.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int?
    let results: [MoviesResponseResults]?
    let totalPages: Int?
    let totalResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

enum SortTypes: String {
    case descending = "desc"
    case ascending = "asc"
}

