//
//  FlagMatcher.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/23/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import UIKit

/// Matching flags agains images stored in app bundle.
class FlagMatcher {
	/// Find small icon flag
	///
	/// - Parameter forCountryCode: code of the country we search flag for
	/// - Returns: Image 100px size
	static func smallFlag(forCountryCode: String?) -> UIImage? {
		if let forCountryCode = forCountryCode {
			let fullImageName = "\(forCountryCode.lowercased()).png"
			return UIImage(named: fullImageName)
		} else {
			return nil
		}
	}
	
	/// Find large flag image
	///
	/// - Parameter forCountryCode: code of the country we search flag for
	/// - Returns: Image 1000px size
	static func largeFlag(forCountryCode: String?) -> UIImage? {
		if let forCountryCode = forCountryCode {
			let flagImageName = "large_" + forCountryCode.lowercased()
			return UIImage(named: flagImageName)
		} else {
			return nil
		}
	}
}
