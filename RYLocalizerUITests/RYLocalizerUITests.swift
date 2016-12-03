//
//  RYLocalizerUITests.swift
//  RYLocalizerUITests
//
//  Created by Yury Radchenko on 25.11.16.
//  Copyright © 2016 Yury Radchenko. All rights reserved.
//

import XCTest
@testable import RYLocalizer

class RYLocalizerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangeLanguage() {
        let app = XCUIApplication()
        app.buttons["Settings"].tap()
        app.tables.staticTexts["Deutsch"].tap()
        app.navigationBars["Sprache"].buttons["Lokalisierer"].tap()
    }
}
