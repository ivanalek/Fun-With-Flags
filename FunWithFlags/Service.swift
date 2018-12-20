//
//  Service.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/16/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

enum ServiceError: Error {
	case networkError(Error)
	case dataNotFound
	case jsonParsingError(Error)
}

enum Result<T> {
	case success(T)
	case failure(ServiceError)
}

protocol ServiceProtocol {
	func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void)
}

/// Class that provides generic fetching skeleton.
class Service: ServiceProtocol {
	/// Generic http GET implementation
	///
	/// - Parameters:
	///   - url: Complete url string for the target
	///   - objectType: Type of the expected result
	///   - completion: Completion called when data is fetched
	func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
		
		let dataURL = URL(string: url)!
		
		// We use shared session because of the simplicity of the app
		let session = URLSession.shared
		let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy)
		
		//create dataTask using the session object to send data to the server
		let task = session.dataTask(with: request, completionHandler: { data, response, error in
			
			guard error == nil else {
				completion(Result.failure(ServiceError.networkError(error!)))
				return
			}
			
			guard let data = data else {
				completion(Result.failure(ServiceError.dataNotFound))
				return
			}
			
			do {
				//create decodable object from data
				let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
				completion(Result.success(decodedObject))
			} catch let error {
				completion(Result.failure(ServiceError.jsonParsingError(error as! DecodingError)))
			}
		})
		
		task.resume()
	}
}
