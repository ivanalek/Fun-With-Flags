//
//  CountryGrouper.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/24/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

/// Arrange CountryViewModel objects into groups suitable for UI presentation
class CountryGrouper {
	/// Group countries by the first letter of ther name.
	///
	/// - Parameter viewModels: Country view models to group
	/// - Returns: Grouped country view models by the first letter of their names.
	func groupCountriesByName(viewModels: [CountryViewModel]) -> [Character? :[CountryViewModel]] {
		return Dictionary(grouping: viewModels, by:  { $0.name().first })
	}
	
	
	/// Extract sorted array of all country first letters of names.
	func sortedCountryGroupNames(groupedCountries: [Character? :[CountryViewModel]]) -> [Character] {
		return groupedCountries.keys.sorted(by: {return $0! <= $1!}) as! [Character]
	}
}
