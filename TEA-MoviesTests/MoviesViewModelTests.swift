//
//  MoviesViewModelTests.swift
//  TEA-MoviesTests
//
//  Created by Alaa Gawish on 04/07/2025.
//

import XCTest
@testable import TEA_Movies

final class MovieViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var mockRepo: MockRepository!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockRepository()
        viewModel = MoviesViewModel(repository: mockRepo)
    }
    
    func testGetMovies() {
     
        let movieResult = MoviesResponseResults(adult: false, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Movie1", overview: "details", popularity: 0, posterPath: "", releaseDate: "2025-1-1", title: "Movie1", video: false, voteAverage: 2, voteCount: 2)
        
        mockRepo.moviesResponseToReturn = MoviesResponse(page: 0, results: [movieResult], totalPages: 0, totalResults: 0)
        
        let expectation = XCTestExpectation(description: "bindMovies called")
        viewModel.bindMovies = {
            expectation.fulfill()
        }
        
       
        viewModel.getMovies(sortedBy: .descending, releaseYear: 2025)
        
      
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.moviesResponse?.results?.first?.title, "Movie1")
    }
    
    func testGetLocalMoviesUpdatesLocalMovies() {
  
        mockRepo.moviesToReturn = [
            MoviesResponseResults(adult: false, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Local movie", overview: "details", popularity: 0, posterPath: "", releaseDate: "2025-1-1", title: "Local movie", video: false, voteAverage: 2, voteCount: 2)
        ]
        
        let expectation = XCTestExpectation(description: "bindLocalMovies called")
        viewModel.bindLocalMovies = {
            expectation.fulfill()
        }
        
    
        viewModel.getLocalMovies()
        
    
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.localMovies?.first?.title, "Local movie")
    }
    
    func testGetFavedMoviesReturnsOnlyFave() {
      
        mockRepo.moviesToReturn = [
            MoviesResponseResults(adult: false, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Movie1", overview: "details", popularity: 0, posterPath: "", releaseDate: "2025-1-1", title: "Movie1", video: false, voteAverage: 2, voteCount: 2, isFave: true),
            MoviesResponseResults(adult: false, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Movie2", overview: "details", popularity: 0, posterPath: "", releaseDate: "2025-1-1", title: "Movie2", video: false, voteAverage: 2, voteCount: 2, isFave: false)
        ]
        
     
        let faves = viewModel.getFavedMovies()
        
 
        XCTAssertEqual(faves.count, 1)
        XCTAssertTrue(faves.first?.isFave == true)
    }
    
    func testClearLocalDBCallsClearAndSave() {
        mockRepo = MockRepository()
        viewModel = MoviesViewModel(repository: mockRepo)
 
        mockRepo.moviesResponseToReturn = MoviesResponse(page: 0, results: [], totalPages: 0, totalResults: 0)
    
        viewModel.clearLocalDB()
        
        XCTAssertTrue(mockRepo.clearAllCalled)
    }
    
    func testChangeMovieFaveCallsRepoAndRefreshes() {
        let movie =  MoviesResponseResults(adult: false, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Movie1", overview: "details", popularity: 0, posterPath: "", releaseDate: "2025-1-1", title: "Movie1", video: false, voteAverage: 2, voteCount: 2, isFave: false)
        mockRepo.moviesToReturn = [movie]
        
        var bindLocalCalled = false
        viewModel.bindLocalMovies = {
            bindLocalCalled = true
        }
        
        viewModel.changeMovieFave(movie: movie, isfave: true)
        
        XCTAssertEqual(mockRepo.changedFaveMovie?.movie.id, movie.id)
        XCTAssertEqual(mockRepo.changedFaveMovie?.isFave, true)
        XCTAssertTrue(bindLocalCalled)
    }
    
    func testCheckInternetConnectionReturnsRepoValue() {
   
        mockRepo.isConnected = false
        let connected = viewModel.checkInternetConnection()
        
        XCTAssertFalse(connected)
    }
}
