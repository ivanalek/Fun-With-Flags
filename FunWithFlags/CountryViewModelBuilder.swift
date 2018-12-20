//
//  CountryViewModelBuilder.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 1/6/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import Foundation

/// Build CountryViewModel
class CountryViewModelBuilder {
	/// Build CountryViewModel array from given country array
	///
	/// - Parameter countries: countries used for building View Models
	/// - Returns: CountryViewModel built array.
	func buildCountryViewModels(countries: [Country]) -> [CountryViewModel]{
		return countries.map { CountryViewModel(country: $0) }
	}
}
