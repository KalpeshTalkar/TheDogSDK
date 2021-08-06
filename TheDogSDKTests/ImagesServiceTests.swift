//
//  ImagesServiceTests.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import XCTest

@testable import TheDogSDK

class ImagesServiceTests: XCTestCase {

    let imagesService = MockImagesService()

    func testImagesSearchWithSuccess() {
        imagesService.mockSuccess = true
        let testExpectation = expectation(description: "Running ImagesService test with success")
        imagesService.searchImages(breed: nil, size: nil, hasBreeds: nil, order: nil, page: nil, limit: nil, mimeTypes: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testImagesSearchWithError() {
        imagesService.mockSuccess = false
        let testExpectation = expectation(description: "Running ImagesService test with error")
        imagesService.searchImages(breed: nil, size: nil, hasBreeds: nil, order: nil, page: nil, limit: nil, mimeTypes: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

}
