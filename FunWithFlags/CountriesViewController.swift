//
//  CountriesViewController.swift
//  FunWithFlags
//
//  Created by Ivan Aleksovski on 12/22/18.
//  Copyright © 2018 ivan. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
	
	enum ViewControllerState {
		case loading
		case loaded
		case error(error: ServiceError)
	}
	
	@IBOutlet weak var retryButton: UIButton!
	
	@IBOutlet weak var loadingLabel: UILabel!
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
	@IBOutlet weak var tableView: UITableView!
	
	private var countryViewModels = [CountryViewModel]()
	private var sortedCountryGroupNames = [Character]()
	private var visibleGroupedCountries = [Character? :[CountryViewModel]]()
	
	private let countriesDataLayer = CountriesDataLayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureSubviews()

		NotificationCenter.default.addObserver(self, selector: #selector(onCountriesUpdated(_:)), name: countriesDataLayer.countriesUpdatedNotification, object: nil)

		applyState(state: .loading)
		loadLocallyStoredCountries()
		countriesDataLayer.refetchDataFromServer()
	}
	
	@objc func onCountriesUpdated(_ notification: Notification) {
		if let error = notification.object as? ServiceError {
			applyState(state: .error(error: error))
		} else {
			loadLocallyStoredCountries()
		}
	}
	
	private func loadLocallyStoredCountries() {
		let countries = countriesDataLayer.persistedCountries()
		if (countries.count > 0) {
			groupCountries(countries: countries)
			tableView.reloadData()
			applyState(state: .loaded)
		}
	}
	
	private func groupCountries(countries: [Country]) {
		countryViewModels = CountryViewModelBuilder().buildCountryViewModels(countries: countries)
		let countryGrouper = CountryGrouper()
		visibleGroupedCountries = countryGrouper.groupCountriesByName(viewModels: countryViewModels)
		sortedCountryGroupNames = countryGrouper.sortedCountryGroupNames(groupedCountries: visibleGroupedCountries)
	}
	
	private func configureSubviews() {
		title = NSLocalizedString("Countries", comment: "")
		tableView.sectionIndexColor = UIColor.accentColor
		tableView.tableFooterView = UIView(frame: CGRect.zero)
		let nib = UINib(nibName: "CountryGroupHeaderView", bundle: nil)
		tableView.register(nib, forHeaderFooterViewReuseIdentifier: CountryGroupHeaderView.reuseIdentifier)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = CountryTableViewCell.estimatedRowHeight
		
		loadingLabel.textColor = UIColor.lightGray
		loadingIndicator.color = UIColor.accentColor
		
		retryButton.setTitleColor(UIColor.accentColor, for:UIControl.State.normal)
	}

	private func countryViewModel(atIndexPath: IndexPath) -> CountryViewModel {
		let sectionKey = sortedCountryGroupNames[atIndexPath.section]
		let countryViewModels = visibleGroupedCountries[sectionKey] ?? [CountryViewModel]()
		let countryViewModel = countryViewModels[atIndexPath.row]
		return countryViewModel
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let countryDetails = segue.destination as? CountryDetailsViewController {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				countryDetails.viewModel = self.countryViewModel(atIndexPath: indexPath)
			}
		}
	}
	
	@IBAction func retryAction(_ sender: Any) {
		applyState(state: .loading)
		countriesDataLayer.refetchDataFromServer()
	}
	
	private func applyState(state: ViewControllerState) {
		switch state {
		case .loading:
			loadingIndicator.startAnimating()
			loadingIndicator.isHidden = false
			loadingLabel.text = NSLocalizedString("Loading...", comment: "")
			loadingLabel.isHidden = false
			retryButton.isHidden = true
		case .loaded:
			loadingIndicator.stopAnimating()
			loadingIndicator.isHidden = true
			loadingLabel.isHidden = true
			retryButton.isHidden = true
		case .error(let error):
			applyErrorState(error: error)
		}
	}
	
	private func applyErrorState(error: ServiceError) {
		switch error {
		case .dataNotFound, .jsonParsingError(_):
			loadingLabel.text = NSLocalizedString("Something went wrong...", comment: "")
		case .networkError(_):
			loadingLabel.text = NSLocalizedString("Please check your internet connection.", comment: "")
		}
		loadingIndicator.stopAnimating()
		loadingIndicator.isHidden = true
		loadingLabel.isHidden = false
		retryButton.isHidden = false
	}
	
	private func setInitiallyLoadedCountries() {
		let countryGrouper = CountryGrouper()
		visibleGroupedCountries = countryGrouper.groupCountriesByName(viewModels: countryViewModels)
		sortedCountryGroupNames = countryGrouper.sortedCountryGroupNames(groupedCountries: visibleGroupedCountries)
	}
}

extension CountriesViewController: UISearchBarDelegate {
	internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		(visibleGroupedCountries, sortedCountryGroupNames) = CountrySearch().filterCountries(keyword: searchText, countryViewModels: countryViewModels)
		tableView.reloadData()
	}
	
	internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		setInitiallyLoadedCountries()
		tableView.reloadData()
		searchBar.resignFirstResponder()
		searchBar.text = ""
	}
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
	internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.countryCellReuseIdentifier, for: indexPath) as! CountryTableViewCell
		
		let countryViewModel = self.countryViewModel(atIndexPath: indexPath)
		cell.configureCell(countryViewModel: countryViewModel)
		
		return cell
	}
	
	internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
	}
	
	internal func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		return sortedCountryGroupNames.compactMap { String($0) }
	}
	
	internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: CountryGroupHeaderView.reuseIdentifier) as! CountryGroupHeaderView
		cell.title.text = sortedCountryGroupNames.compactMap { String($0) }[section]
		return cell
	}
	
	internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CountryGroupHeaderView.defaultHeight
	}
	
	internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return CGFloat.leastNormalMagnitude
	}
	
	internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let sectionKey = self.sortedCountryGroupNames[section]
		return visibleGroupedCountries[sectionKey]?.count ?? 0
	}
	
	internal func numberOfSections(in tableView: UITableView) -> Int {
		return sortedCountryGroupNames.count
	}
}
