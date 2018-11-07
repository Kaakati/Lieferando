//
//  CTAVendorsList.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

/*
  Should add "BaseViewProtocol" after "class" if want to act as UIViewController;
  & that will allow the View to act as a UIViewController;
  & Implement common view functions.
*/
// MARK: View -
/// TAVendorsList Module View Protocol
protocol VTAVendorsListProtocol: BaseViewProtocol {
	// Update UI with value returned.
	/// Set the view Object of Type ETAVendorsList
	func set(object: Results<ETAVendorsList>?)
    // Should Open Filters
    func shouldOpenFilters(_ forView: VTAVendorsListProtocol)
//    func shouldOpenFilters(_ forView: VTAVendorsListProtocol)
}

// MARK: Interactor -
/// TAVendorsList Module Interactor Protocol
protocol ITAVendorsListProtocol {
	// Fetch Object from Data Layer
	func fetch(objectFor presenter: PTAVendorsListProtocol)
    // User Did Filter Results
    func sortingResults(_ presenter: PTAVendorsListProtocol, filterType : AvailableSortings)
    //
    func userDidTapFavouriteBtn(_ presenter: PTAVendorsListProtocol, forObject id: String)
    //
    func userSearchEvent(_ stringValue : String)
}

// MARK: Presenter -
/// TAVendorsList Module Presenter Protocol
protocol PTAVendorsListProtocol {
	/// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
	func fetch(objectFor view: VTAVendorsListProtocol)
	/// The Interactor will inform the Presenter a successful fetch.
	func interactor(_ interactor: ITAVendorsListProtocol, didFetch object: Results<ETAVendorsList>?)
	/// The Interactor will inform the Presenter a failed fetch.
	func interactor(_ interactor: ITAVendorsListProtocol, didFailWith error: Error)
    
    func userDidTapFavouriteBtn(_ onView: VTAVendorsListProtocol, forObject id: String)
    
    func sortingResults(_ onView: VTAVendorsListProtocol, filterType : AvailableSortings)
    
    func viewDidRequestSortingResults(_ interactor: ITAVendorsListProtocol, filterType : AvailableSortings)
    
//    func shouldOpenFilters(_ fromView: VTAVendorsListProtocol, withValues value: String)
    
    func userSearchEvent(_ stringValue : String)
}

// MARK: Router (aka: Wireframe) -
/// TAVendorsList Module Router Protocol
protocol RTAVendorsListProtocol {
	// Show Details of Entity Object coming from ParentView Controller.
	// func showDetailsFor(object: ETAVendorsList, parentViewController viewController: UIViewController)
}
