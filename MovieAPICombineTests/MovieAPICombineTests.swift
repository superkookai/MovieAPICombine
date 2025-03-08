//
//  MovieAPICombineTests.swift
//  MovieAPICombineTests
//
//  Created by Weerawut Chaiyasomboon on 08/03/2568.
//

import XCTest
import Combine

final class MovieAPICombineTests: XCTestCase {
    private var cancllables: Set<AnyCancellable> = []

    func testFetchMovies() throws {
        let expectation = XCTestExpectation(description: "Received Movies")
        let httpClient = HTTPClient()
        
        httpClient.fetchMovies(search: "Batman")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(movies.count > 0)
                expectation.fulfill()
            }
            .store(in: &cancllables)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
