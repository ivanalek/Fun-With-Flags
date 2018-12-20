//
//  CountryDetailsViewController.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/23/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailsViewController: UIViewController {
	var viewModel: CountryViewModel!
	
	@IBOutlet private weak var flag: UIImageView!
	@IBOutlet private weak var name: UILabel!
	@IBOutlet private weak var nativeName: UILabel!
	@IBOutlet private weak var capital: UILabel!
	@IBOutlet private weak var region: UILabel!
	@IBOutlet private weak var callingCodes: UILabel!
	@IBOutlet private weak var map: MKMapView!
	@IBOutlet private weak var pageControl: UIPageControl!
	@IBOutlet private weak var population: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureSubviews()
		bindViewModel()
	}
	
	private func bindViewModel() {
		flag.image = viewModel.largeFlag()
		name.text = viewModel.name()
		nativeName.attributedText = viewModel.descriptiveNativeName()
		capital.attributedText = viewModel.descriptiveCapital()
		region.attributedText = viewModel.descriptiveRegion()
		callingCodes.attributedText = viewModel.descriptiveCallingCodes()
		population.attributedText = viewModel.descriptivePopulation()
		
		if let region = viewModel.countryMapRegion() {
			map.setRegion(region, animated: false)
		}
	}
	
	private func configureSubviews() {
		navigationController?.navigationBar.tintColor = UIColor.accentColor
		pageControl.tintColor = UIColor.lightGray
		pageControl.currentPageIndicatorTintColor = UIColor.accentColor
		
		self.flag.layer.borderWidth = 1
		self.flag.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
	}
}

extension CountryDetailsViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
		pageControl.currentPage = pageIndex
	}
}
