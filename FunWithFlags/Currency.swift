//
//  Currency.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/22/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

struct Currency : Equatable {
	let code: String?
	let name: String?
	let symbol: String?
}

extension Currency: Codable {
	enum CodingKeys: String, CodingKey {
		case code = "code"
		case name = "name"
		case symbol = "symbol"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
	}
}
