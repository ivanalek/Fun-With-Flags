//
//  CountryModelTests.swift
//  FunWithFlagsTests
//
//  Created by Ivan Aleksovski on 1/6/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import XCTest
@testable import FunWithFlags

class CountryModelTests: XCTestCase {
	
	var countryJSONContent: Data!
	
	override func setUp() {
		let testBundle = Bundle(for: type(of: self))
		if let fileURL = testBundle.url(forResource: "Country", withExtension: "json") {
			countryJSONContent = try! Data.init(contentsOf: fileURL)
		}
	}
	
	override func tearDown() {
		countryJSONContent = nil
	}
	
	func testJSONInit() {
		print(countryJSONContent ?? "")
		let country = try? JSONDecoder().decode(Country.self, from: countryJSONContent)
		print(country!)
		XCTAssertNotNil(country)
		XCTAssert(country?.name == "Macedonia (the former Yugoslav Republic of)")
		XCTAssert(country?.nativeName == "Македонија")
		XCTAssert(country?.region == "Europe")
		XCTAssert(country?.alpha2Code == "MK")
	}
}
