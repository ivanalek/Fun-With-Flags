//
//  SimpleUsageTests.swift
//  FunWithFlagsUITests
//
//  Created by Ivan Aleksovski on 1/7/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import XCTest

class SimpleUsageTests: XCTestCase {
	var app: XCUIApplication!

	override func setUp() {
		
		continueAfterFailure = false
		
		app = XCUIApplication()
		app.launch()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testCountrySelect() {
		app.tables.cells.staticTexts["Albania"].tap()

		let nameLabel = app.staticTexts["Albania"]
		XCTAssertTrue(nameLabel.exists)
	}
	
	func testCountrySearchMatch() {
		app.tables.searchFields["Search Countries"].tap()
		app.tables.searchFields["Search Countries"].typeText("Mace")
		app.tables.cells.staticTexts["Macedonia (the former Yugoslav Republic of)"].tap()
		
		let nameLabel = app.staticTexts["Macedonia (the former Yugoslav Republic of)"]
		XCTAssertTrue(nameLabel.exists)
	}
	
	func testCountrySearchMiss() {
		app.tables.searchFields["Search Countries"].tap()
		app.tables.searchFields["Search Countries"].typeText("ZZZZZ")
		XCTAssert(app.tables.staticTexts.count == 0)
	}
	
}
