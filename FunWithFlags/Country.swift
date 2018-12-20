//
//  Country.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/20/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import Foundation

struct Country: Equatable {
	let name: String?
	let topLevelDomain: [String]?
	let alpha2Code: String?
	let alpha3Code: String?
	let callingCodes: [String]?
	let capital: String?
	let altSpellings: [String]?
	let region: String?
	let subregion: String?
	let population: Int?
	let latlng: [Double]?
	let demonym: String?
	let area: Double?
	let gini: Double?
	let timezones: [String]?
	let borders: [String]?
	let nativeName: String?
	let numericCode: String?
	let currencies: [Currency]?
	let languages: [Language]?
	let translations: Translation?
	let flag: String?
	let regionalBlocs: [RegionalBloc]?
	let cioc: String?
}

extension Country: Codable {
	enum CodingKeys: String, CodingKey {
		case name = "name"
		case topLevelDomain = "topLevelDomain"
		case alpha2Code = "alpha2Code"
		case alpha3Code = "alpha3Code"
		case callingCodes = "callingCodes"
		case capital = "capital"
		case altSpellings = "altSpellings"
		case region = "region"
		case subregion = "subregion"
		case population = "population"
		case latlng = "latlng"
		case demonym = "demonym"
		case area = "area"
		case gini = "gini"
		case timezones = "timezones"
		case borders = "borders"
		case nativeName = "nativeName"
		case numericCode = "numericCode"
		case currencies = "currencies"
		case languages = "languages"
		case translations = "translations"
		case flag = "flag"
		case regionalBlocs = "regionalBlocs"
		case cioc = "cioc"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		topLevelDomain = try values.decodeIfPresent([String].self, forKey: .topLevelDomain)
		alpha2Code = try values.decodeIfPresent(String.self, forKey: .alpha2Code)
		alpha3Code = try values.decodeIfPresent(String.self, forKey: .alpha3Code)
		callingCodes = try values.decodeIfPresent([String].self, forKey: .callingCodes)
		capital = try values.decodeIfPresent(String.self, forKey: .capital)
		altSpellings = try values.decodeIfPresent([String].self, forKey: .altSpellings)
		region = try values.decodeIfPresent(String.self, forKey: .region)
		subregion = try values.decodeIfPresent(String.self, forKey: .subregion)
		population = try values.decodeIfPresent(Int.self, forKey: .population)
		latlng = try values.decodeIfPresent([Double].self, forKey: .latlng)
		demonym = try values.decodeIfPresent(String.self, forKey: .demonym)
		area = try values.decodeIfPresent(Double.self, forKey: .area)
		gini = try values.decodeIfPresent(Double.self, forKey: .gini)
		timezones = try values.decodeIfPresent([String].self, forKey: .timezones)
		borders = try values.decodeIfPresent([String].self, forKey: .borders)
		nativeName = try values.decodeIfPresent(String.self, forKey: .nativeName)
		numericCode = try values.decodeIfPresent(String.self, forKey: .numericCode)
		currencies = try values.decodeIfPresent([Currency].self, forKey: .currencies)
		languages = try values.decodeIfPresent([Language].self, forKey: .languages)
		translations = try values.decodeIfPresent(Translation.self, forKey: .translations)
		flag = try values.decodeIfPresent(String.self, forKey: .flag)
		regionalBlocs = try values.decodeIfPresent([RegionalBloc].self, forKey: .regionalBlocs)
		cioc = try values.decodeIfPresent(String.self, forKey: .cioc)
	}
}
