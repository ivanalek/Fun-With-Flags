//
//  CountriesPersistence.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 1/6/19.
//  Copyright © 2019 ivan. All rights reserved.
//

import Foundation

/// Data Layer for countries. Provides persistance and fetching from the Api.
class CountriesDataLayer {
	
	/// Name of the notification fired when there is new fetched data from the Api.
	let countriesUpdatedNotification = Notification.Name("CountriesUpdated")

	/// API_BASE_URL is expected to be stored in Info.plist file
	private let countriesService = CountriesService(serverEndpoint: Bundle.main.infoDictionary!["API_BASE_URL"] as! String)

	/// Fires new fetch request from the Api. If the fetched result is different that currently persisted countries, notification with `countriesUpdatedNotification` is fired up.
	func refetchDataFromServer() {
		countriesService.countries { [weak self] (result: Result<[Country]>) in
			guard let this = self else {
				return
			}

			switch result {
			case .success(let countries):
				if (this.persistIfChanged(countries: countries)) {
					// Report update only if something from the countries info differs from the previous fetch
					DispatchQueue.main.async {
						NotificationCenter.default.post(name: this.countriesUpdatedNotification, object: nil)
					}
				}
			case .failure(let error):
				DispatchQueue.main.async {
					if (this.persistedCountries().count == 0) {
						// Report the error only if we dont have countries to show
						NotificationCenter.default.post(name: this.countriesUpdatedNotification, object: error)
					}
				}
			}
		}
	}
	
	/// Reads the persisted countries on disk.
	///
	/// - Returns: persisted countries array
	func persistedCountries() -> [Country] {
		let decoder = JSONDecoder()
		if let countriesData = UserDefaults.standard.data(forKey: "Countries"),
			let countries = try? decoder.decode([Country].self, from: countriesData) {
			return countries
		}
		return [Country]()
	}
	
	/// Persists countries on disk, only if the new data is different than the existing one.
	///
	/// - Parameter countries: countries to persist.
	/// - Returns: True if countries were different that the existing ones.
	private func persistIfChanged(countries: [Country]) -> Bool {
		let alreadyPersistedCountries = self.persistedCountries()
		
		if (alreadyPersistedCountries != countries) {
			self.persistCountries(countries: countries)
			return true
		}
		return false
	}
	
	private func persistCountries(countries: [Country]) {
		if let encoded = try? JSONEncoder().encode(countries) {
			UserDefaults.standard.set(encoded, forKey: "Countries")
		}
	}

}
