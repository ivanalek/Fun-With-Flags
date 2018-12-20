//
//  CountryViewModelTests.swift
//  FunWithFlagsTests
//
//  Created by Ivan Aleksovski on 1/6/19.
//  Copyright © 2019 ivan. All rights reserved.
//


import XCTest
@testable import FunWithFlags

class CountryViewModelTests: XCTestCase {
	
	var countryViewModel: CountryViewModel!
	
	override func setUp() {
		let testBundle = Bundle(for: type(of: self))
		if let fileURL = testBundle.url(forResource: "Country", withExtension: "json") {
			let countryJSONContent = try! Data.init(contentsOf: fileURL)
			let country = try! JSONDecoder().decode(Country.self, from: countryJSONContent)
			countryViewModel = CountryViewModel(country: country)
		}
	}
	
	override func tearDown() {
		countryViewModel = nil
	}
	
	func testCountryViewModelConstruction() {
		XCTAssertNotNil(countryViewModel)
	}
	
	func testCountryViewModelDescriptiveData() {
		XCTAssert(countryViewModel.name() == "Macedonia (the former Yugoslav Republic of)")
		XCTAssert(countryViewModel.descriptiveNativeName().string == "Native Name: Македонија")
		XCTAssert(countryViewModel.descriptiveCapital().string == "Capital: Skopje")
		XCTAssert(countryViewModel.descriptiveRegion().string == "Region: Europe")
		XCTAssert(countryViewModel.descriptiveCallingCodes().string == "Calling Codes: 389")
		XCTAssert(countryViewModel.descriptivePopulation().string == "Population: 2,058,539")
	}
	
	func testCountryViewModelLargeIcon() {
		XCTAssert(countryViewModel.largeFlag()?.pngData() == UIImage(named: "large_mk")?.pngData())
	}
	
	func testCountryViewModelSmallIcon() {
		XCTAssert(countryViewModel.smallFlag()?.pngData() == UIImage(named: "mk")?.pngData())
	}
	
	func testCountryViewModelMapRegion() {
		XCTAssert(countryViewModel.countryMapRegion()?.center.latitude == 41.83333333)
		XCTAssert(countryViewModel.countryMapRegion()?.center.longitude == 22.0)
		XCTAssert(countryViewModel.countryMapRegion()?.span.latitudeDelta == 1.7324502584147656)
		XCTAssert(countryViewModel.countryMapRegion()?.span.longitudeDelta == 2.3164947590697595)
	}
	
	func testCountryViewModelMatchesKeyword() {
		XCTAssertNotNil(countryViewModel)
	}
	
	func testCountryViewModelMissesKeyword() {
		XCTAssertNotNil(countryViewModel)
	}
}
