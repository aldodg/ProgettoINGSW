//
//  CinematesTests.swift
//  CinematesTests
//
//  Created by Aldo Di Giovanni on 21/08/22.
//  Copyright © 2022 Aldo Di Giovanni. All rights reserved.
//

import XCTest
import Foundation

class CinematesTests: XCTestCase {
    
    var userMovieList : UserMovieListResponse?
    var apiError : Error? = nil
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldGetFavouritesMovies() throws {
        // MARK: - Arranging test case dependencies
        let movieListsRepo = ApiList()
        var response : [MovieList]? = nil
        var errorResponse : Error? = nil
        let expectation = self.expectation(description: "Waiting for a non empty movie list")
        // MARK: - Acting to get the expected result
        movieListsRepo.loadData(num: "1") { movieLists, error  in
            // Fullfil the expectation to let the test runner
            // know that it's OK to proceed
            response = movieLists.movieLists
            errorResponse = error
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // MARK: - Asserting that expected results are the got ones.
        XCTAssertNil(errorResponse)
        response?.forEach({ list in
            if (list.listName == "preferiti") {
                XCTAssertGreaterThan(list.movies.count, 0)
            }
        })
    }
    
    func testShouldGetCorrectUserById() throws {
        // MARK: - Arranging test case dependencies
        let userRepo = ApiUser()
        var userResponse : Person? = nil
        let expectation = self.expectation(description: "Waiting for the exiting user")
        // MARK: - Acting to get the expected result
        userRepo.loadDataUser(num: "1") { user  in
            // Fullfil the expectation to let the test runner
            // know that it's OK to proceed
            userResponse = user.results.first
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        // MARK: - Asserting that expected results are the got ones.
        XCTAssertEqual(userResponse?.username, "accr0")
        XCTAssertEqual(userResponse?.email, "accro@gmail.com")
    }
    
    
    func testRatingTextShouldBeCorrectAccordingToAverage() throws {
        // MARK: - Arranging test case stubs
        let threeStarMovie = Movie(id: 0, voteAverage: 3.49)
        let fourStarMovie = Movie(id: 0, voteAverage: 3.51)
        // MARK: - Acting to get the expected result
        let threeStarRatingText = threeStarMovie.ratingText
        let fourStarRatingText = fourStarMovie.ratingText
        // MARK: - Asserting that expected results are the got ones.
        XCTAssertEqual(threeStarRatingText, "★★★")
        XCTAssertEqual(fourStarRatingText, "★★★★")
    }
    
    func testYearTextShouldBeCorrectAccordingToRelease() throws {
        // MARK: - Arranging test case stubs
        let newMilleniumMovie = Movie(id: 0, releaseDate: "2001-01-01")
        let malformedReleaseDateMovie = Movie(id: 0, releaseDate: "notARealDate")
        // MARK: - Acting to get the expected result
        let yearText = newMilleniumMovie.yearText
        let uncorrectYearText = malformedReleaseDateMovie.yearText
        // MARK: - Asserting that expected results are the got ones.
        XCTAssertEqual(yearText, "2001")
        XCTAssertEqual(uncorrectYearText, "n/a")
    }
    
}
