//
//  CountryTableViewCell.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/23/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import UIKit

/// Cell for simple presentation of CountryViewModel. Displays country name, region and small flag icon.
class CountryTableViewCell: UITableViewCell {
	public static let countryCellReuseIdentifier = "CountryCell"
	
	@IBOutlet private weak var flagImage: UIImageView!
	@IBOutlet private weak var countryTitle: UILabel!
	@IBOutlet private weak var countryQuickDescription: UILabel!
	
	
	/// Used for adjusting the AutoCellHeight behaviour
	static let estimatedRowHeight: CGFloat = 67.0
	
	/// Apply CountryViewModel state to the cell
	///
	/// - Parameter countryViewModel: 
	func configureCell(countryViewModel: CountryViewModel) {
		configureCell(flag: countryViewModel.smallFlag(), title: countryViewModel.name(), quickDescription: countryViewModel.region())
	}
	
	private func configureCell(flag: UIImage?, title: String, quickDescription: String) {
		if let flag = flag {
			flagImage.image = flag
		}
		configureSubviews()
		countryTitle.text = title
		countryQuickDescription.text = quickDescription
	}
	
	private func configureSubviews() {
		self.flagImage.layer.cornerRadius = self.flagImage.frame.width/2.0
		self.flagImage.clipsToBounds = true
		self.flagImage.layer.borderWidth = 1.0
		self.flagImage.layer.borderColor = UIColor.lightGray.cgColor
	}
	
	override func prepareForReuse() {
		flagImage.image = nil
		countryTitle.text = ""
		countryQuickDescription.text = ""
	}
}
