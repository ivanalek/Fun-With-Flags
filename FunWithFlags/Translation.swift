//
//  Translation.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/22/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

struct Translation: Equatable {
	let de: String?
	let es: String?
	let fr: String?
	let ja: String?
	let it: String?
	let br: String?
	let pt: String?
	let nl: String?
	let hr: String?
	let fa: String?
}

extension Translation: Codable {
	enum CodingKeys: String, CodingKey {
		case de = "de"
		case es = "es"
		case fr = "fr"
		case ja = "ja"
		case it = "it"
		case br = "br"
		case pt = "pt"
		case nl = "nl"
		case hr = "hr"
		case fa = "fa"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		de = try values.decodeIfPresent(String.self, forKey: .de)
		es = try values.decodeIfPresent(String.self, forKey: .es)
		fr = try values.decodeIfPresent(String.self, forKey: .fr)
		ja = try values.decodeIfPresent(String.self, forKey: .ja)
		it = try values.decodeIfPresent(String.self, forKey: .it)
		br = try values.decodeIfPresent(String.self, forKey: .br)
		pt = try values.decodeIfPresent(String.self, forKey: .pt)
		nl = try values.decodeIfPresent(String.self, forKey: .nl)
		hr = try values.decodeIfPresent(String.self, forKey: .hr)
		fa = try values.decodeIfPresent(String.self, forKey: .fa)
	}
}
