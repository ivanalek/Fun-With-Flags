//
//  CountrySearch.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 1/6/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import Foundation

class CountrySearch {
	/// Search through countries by a given keyword. Results are based on `CountryViewModel` **matchesKeyword** method behaviour.
	///
	/// - Parameters:
	///   - keyword: keyword to match against the country view models
	///   - countryViewModels: array to match against
	/// - Returns: Items matching the keуword
	func filterCountries(keyword: String, countryViewModels: [CountryViewModel]) -> ([Character? :[CountryViewModel]], [Character]) {
		let countryGrouper = CountryGrouper()
		let filteredViewModels = countryViewModels.filter { $0.matchesKeyword(keyword: keyword)}
		let filteredCountries = countryGrouper.groupCountriesByName(viewModels: filteredViewModels)
		let filteredSortedCountryGroupNames = countryGrouper.sortedCountryGroupNames(groupedCountries: filteredCountries)
		return (filteredCountries, filteredSortedCountryGroupNames)
	}
}
