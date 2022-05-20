//
//  NeuroIdExampleUITests.swift
//  NeuroIdExampleUITests
//
//  Created by jose perez on 18/05/22.
//

import XCTest
@testable import NeuroIdExample

class NeuroIdExampleUITests: XCTestCase {
    ///
    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication()
        try super.setUpWithError()
        continueAfterFailure = true
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCreateSessionID() {
        app.buttons["Get Started"].tap()
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 1).swipeUp()
        element.children(matching: .other).element(boundBy: 11).swipeUp()
        scrollViewsQuery.otherElements.buttons["Continue"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Agree and Check Tour Loan Options"]/*[[".buttons[\"Agree and Check Tour Loan Options\"].staticTexts[\"Agree and Check Tour Loan Options\"]",".staticTexts[\"Agree and Check Tour Loan Options\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
