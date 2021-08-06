//
//  TheDogSDKTests.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 20/04/21.
//

import XCTest
@testable import TheDogSDK

class TheDogSDKTests: XCTestCase {

    var sut: DogSDKService!

    override func setUp() {
        super.setUp()
        let imagesService = MockImagesService()
        let breedsService = MockBreedsService()
        sut = DogSDKService(imagesService: imagesService, breedsSerivce: breedsService)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSearchImagesWithSuccess() {
        let testExpectation = expectation(description: "Running DogSDKService test search images with success")
        sut.searchImages(params: BreedImageParams()) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testSearchImagesWithError() {
        let imagesService = MockImagesService()
        imagesService.mockSuccess = false
        let breedsService = MockBreedsService()
        breedsService.mockSuccess = false
        sut = DogSDKService(imagesService: imagesService, breedsSerivce: breedsService)

        let testExpectation = expectation(description: "Running DogSDKService test search images with error")
        sut.searchImages(params: BreedImageParams()) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsWithSuccess() {
        let testExpectation = expectation(description: "Running DogSDKService test with success")
        sut.getAllBreeds(page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsWithError() {
        let imagesService = MockImagesService()
        imagesService.mockSuccess = false
        let breedsService = MockBreedsService()
        breedsService.mockSuccess = false
        sut = DogSDKService(imagesService: imagesService, breedsSerivce: breedsService)

        let testExpectation = expectation(description: "Running DogSDKService test with error")
        sut.getAllBreeds(page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithSuccess() {
        let testExpectation = expectation(description: "Running DogSDKService test with error")
        sut.searchBreeds(breedName: "pug", page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithNoResults() {
        let imagesService = MockImagesService()
        imagesService.mockSuccess = true
        let breedsService = MockBreedsService()
        breedsService.mockSuccess = true
        breedsService.emptyResults = true
        sut = DogSDKService(imagesService: imagesService, breedsSerivce: breedsService)

        let testExpectation = expectation(description: "Running DogSDKService test with error")
        sut.searchBreeds(breedName: "asdf", page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertTrue(result?.data?.isEmpty ?? false)
            XCTAssertNil(error)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

    func testBreedsSearchWithError() {
        let imagesService = MockImagesService()
        imagesService.mockSuccess = false
        let breedsService = MockBreedsService()
        breedsService.mockSuccess = false
        sut = DogSDKService(imagesService: imagesService, breedsSerivce: breedsService)

        let testExpectation = expectation(description: "Running DogSDKService test with error")
        sut.searchBreeds(breedName: "asdf", page: nil, limit: nil) { (result, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 1)
    }

}
