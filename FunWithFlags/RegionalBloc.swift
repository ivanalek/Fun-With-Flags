//
//  RegionalBlock.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/22/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation
struct RegionalBloc: Equatable {
	let acronym: String?
	let name: String?
	let otherAcronyms: [String]?
	let otherNames: [String]?
}

extension RegionalBloc: Codable {
	enum CodingKeys: String, CodingKey {
		case acronym = "acronym"
		case name = "name"
		case otherAcronyms = "otherAcronyms"
		case otherNames = "otherNames"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		acronym = try values.decodeIfPresent(String.self, forKey: .acronym)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		otherAcronyms = try values.decodeIfPresent([String].self, forKey: .otherAcronyms)
		otherNames = try values.decodeIfPresent([String].self, forKey: .otherNames)
	}
}
