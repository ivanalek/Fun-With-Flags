//
//  CountryViewModel.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 1/3/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import UIKit
import MapKit

/// ViewModel that adjusts **Country** object for UI presentation
class CountryViewModel {
	private let country: Country!
	private let titleColorStyle = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
	private let valueColorStyle = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]

	init(country: Country) {
		self.country = country
	}
	
	/// Used for searching through view models.
	///
	/// - Parameter keyword: keyword to match against the country view model
	/// - Returns: True if country matches the keyword. Keyword is matched against name, native name, and translated name variations
	func matchesKeyword(keyword: String) -> Bool {
		// return self.range(of: find, options: .caseInsensitive) != nil
		let matchesName = country.name?.range(of: keyword, options: .caseInsensitive) != nil
		let matchesNativeName = country.nativeName?.range(of: keyword, options: .caseInsensitive) != nil
		let matchesTranslation = matchesTranslatedName(keyword: keyword)
		return matchesName || matchesNativeName || matchesTranslation
	}
	
	private func matchesTranslatedName(keyword: String) -> Bool {
		var matchesTranslation = false
		
		if (country.translations?.de?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.es?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.fr?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.it?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.br?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.pt?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.nl?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.hr?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		if (country.translations?.fa?.range(of: keyword, options: .caseInsensitive)) != nil {
			matchesTranslation = true
		}
		
		return matchesTranslation
	}
	
	/// Large Image for the country flag
	///
	/// - Returns: Image result 1000px
	func largeFlag() -> UIImage? {
		return FlagMatcher.largeFlag(forCountryCode: country.alpha2Code)
	}
	
	/// Small Icon Image for the country flag
	///
	/// - Returns: Image result 100px
	func smallFlag() -> UIImage? {
		return FlagMatcher.smallFlag(forCountryCode: country.alpha2Code)
	}
	
	/// Country Name
	///
	/// - Returns: Country name or "n/a" if name not available
	func name() -> String {
		return country.name ?? NSLocalizedString("n/a", comment: "")
	}
	
	/// Country Region
	///
	/// - Returns: Country region or "n/a" if region is not available
	func region() -> String {
		return country.region ?? NSLocalizedString("n/a", comment: "")
	}
	
	/// Country Native Name
	///
	/// - Returns: Country Native Name or "n/a" if region is not available, accompanied with caption.
	func descriptiveNativeName() -> NSAttributedString {
		let title = NSLocalizedString("Native Name: ", comment: "")
		let value = country.nativeName ?? NSLocalizedString("n/a", comment: "")
		return applyStyle(title: title, value: value)
	}
	
	/// Country Capital
	///
	/// - Returns: Country Capital or "n/a" if capital is not available, accompanied with caption.
	func descriptiveCapital() -> NSAttributedString {
		let title = NSLocalizedString("Capital: ", comment: "")
		let value = country.capital ?? NSLocalizedString("n/a", comment: "")
		return applyStyle(title: title, value: value)
	}
	
	/// Country Region
	///
	/// - Returns: Country Region or "n/a" if region is not available, accompanied with caption.
	func descriptiveRegion() -> NSAttributedString {
		let title = NSLocalizedString("Region: ", comment: "")
		let value = country.region ?? NSLocalizedString("n/a", comment: "")
		return applyStyle(title: title, value: value)
	}
	
	/// Country Calling Codes
	///
	/// - Returns: Concatenated Country Calling Codes, accompanied with caption.
	func descriptiveCallingCodes() -> NSAttributedString {
		let title = NSLocalizedString("Calling Codes: ", comment: "")
		let callingCodes = readableArrayContent(arr: country.callingCodes ?? [""])
		return applyStyle(title: title, value: callingCodes)
	}
	
	private func readableArrayContent(arr: [String]) -> String {
		return arr.joined(separator: ", ")
	}

	/// MKMap region that is focused on the gived country
	///
	/// - Returns: Region approximateley zoomed in to focus the whole country.
	func countryMapRegion() -> MKCoordinateRegion? {
		if let lat = country?.latlng?[0], let lng = country?.latlng?[1], let area = country?.area  {
			// Close enough approximation of the country radius extracted from the country area info. Note that this is based on assumption that the country has regular circle form which is not always true.
			let metersInKm = 1000.0
			let countryDiameter = sqrt(area) * metersInKm
			let countryDiameterWithOffset = countryDiameter * 1.2
			let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
			let region = MKCoordinateRegion(center: center, latitudinalMeters: countryDiameterWithOffset, longitudinalMeters: countryDiameterWithOffset)
			return region
		}
		return nil
	}
	
	/// Country Population
	///
	/// - Returns: Formatted Country Population number or "n/a" if number is not available, accompanied with caption.
	func descriptivePopulation() -> NSAttributedString {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		let title = NSLocalizedString("Population: ", comment: "")
		let population = numberFormatter.string(for: country.population) ?? NSLocalizedString("n/a", comment: "")
		return applyStyle(title: title, value: population)
	}
	
	private func applyStyle(title: String, value: String) -> NSAttributedString {
		let attributedTitle = NSMutableAttributedString(string: title, attributes: titleColorStyle)
		let attributedValue = NSAttributedString(string: value, attributes: valueColorStyle)
		attributedTitle.append(attributedValue)
		return attributedTitle
	}

}
