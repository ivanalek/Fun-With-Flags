//
//  CountriesService.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/16/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

/// Service for fetching countries data
class CountriesService {
	private let service = Service()
	private let url: String!
	
	/// Init
	///
	/// - Parameter serverEndpoint: Full url for the countries data API.
	init(serverEndpoint: String) {
		self.url = serverEndpoint
	}
	
	/// Fetch countries data
	///
	/// - Parameter completion: completion closure called when data is fetched or fetch fails
	func countries(completion: @escaping (Result<[Country]>) -> Void) {
		service.dataRequest(with: url, objectType: [Country].self) { (result: Result<[Country]>) in
			completion(result)
		}
	}
}
