//
//  BreedsServiceTests.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import XCTest

@testable import TheDogSDK

class BreedsServiceTests: XCTestCase {

    let breedsService = MockBreedsService()

    func testBreedsWithSuccess() {
        breedsService.mockSuccess = true
        let testExpectation = expectation(description: "Running BreedsService test with success")
        breedsService.getAllBreeds(page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsWithError() {
        breedsService.mockSuccess = false
        let testExpectation = expectation(description: "Running BreedsService test with error")
        breedsService.getAllBreeds(page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithSuccess() {
        breedsService.mockSuccess = true
        breedsService.emptyResults = false
        let testExpectation = expectation(description: "Running BreedsService test with success")
        breedsService.searchBreeds(breedName: "pug",page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithNoResults() {
        breedsService.mockSuccess = false
        breedsService.emptyResults = true
        let testExpectation = expectation(description: "Running BreedsService test with error")
        breedsService.searchBreeds(breedName: "asdf",page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithError() {
        breedsService.mockSuccess = false
        let testExpectation = expectation(description: "Running BreedsService test with error")
        breedsService.searchBreeds(breedName: "asdf",page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }
}
