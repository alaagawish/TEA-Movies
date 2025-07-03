//
//  MoviesResponseResults.swift
//  TEA-Movies
//
//  Created by Alaa Gawish on 03/07/2025.
//

import Foundation

struct MoviesResponseResults: Codable {
    
    let adult: Bool?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Int?
    let voteCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}
