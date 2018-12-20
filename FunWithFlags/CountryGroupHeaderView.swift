//
//  CountryGroupHeaderView.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/24/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import UIKit

/// Dumb reusable Heder View that simply displays one text label
class CountryGroupHeaderView: UITableViewHeaderFooterView {
	@IBOutlet weak var title: UILabel!
	
	public static let reuseIdentifier = "CountryGroupHeaderView"
	public static let defaultHeight: CGFloat = 45.0
}


