//
//  DemoAppUITests.swift
//  DemoAppUITests
//
//  Created by Kalpesh on 21/04/21.
//

import XCTest

class BaseUITest: XCTestCase {

    var app = XCUIApplication()

    let defaultLaunchArguments: [String] = [
        "-uiAutomationTest"
    ]

    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        // However, we want to run all the UI tests and later on see the test logs for failed tests.
        continueAfterFailure = true

        app.launchArguments.append(contentsOf: [
            "-uiAutomationTest"
        ])
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }

    func takeScreenshot(name: String) {
        let fullScreenshot = XCUIScreen.main.screenshot()
        let screenshot = XCTAttachment(uniformTypeIdentifier: "public.png", name: "Screenshot-\(name)-\(UIDevice.current.name).png", payload: fullScreenshot.pngRepresentation, userInfo: nil)
        screenshot.lifetime = .keepAlways
        add(screenshot)
    }
}

class DemoAppUITests: BaseUITest {

    func testSomething() {
        sleep(5)

        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 7).tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.tap()

        let breedsButton = app.navigationBars["Breed Images"].buttons["Breeds"]
        breedsButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 10).children(matching: .other).element.tap()

        let searchByBreedNameSearchField = app.searchFields["Search by breed name..."]
        searchByBreedNameSearchField.tap()
        app.staticTexts["Cancel"].tap()
        searchByBreedNameSearchField.tap()
        breedsButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 14).children(matching: .other).element.tap()
    }
}
