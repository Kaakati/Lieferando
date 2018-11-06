//
//  VTAVendorsList.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

/// TAVendorsList Module View
class VTAVendorsList: UIViewController {

	private let ui = VTAVendorsListUI()
	private var presenter: PTAVendorsListProtocol!

    private var object : Results<ETAVendorsList>? {
        didSet {
            if object != nil {
                self.ui.reloadData()
            }
        }
    }

	override func loadView() {
		// setting the custom view as the view controller's view
		ui.delegate = self
		ui.dataSource = self
		view = ui
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PTAVendorsList(view: self)
		// Informs the Presenter that the View is ready to receive data.
		presenter.fetch(objectFor: self)
    }
    
}

// MARK: - extending VTAVendorsList to implement it's protocol
extension VTAVendorsList: VTAVendorsListProtocol {
    func shouldOpenFilters(_ forView: VTAVendorsListProtocol) {
        self.view.addSubview(self.ui.filterPicker)
    }
    
    func set(object: Results<ETAVendorsList>?) {
        self.object = object
    }
}

// MARK: - extending VTAVendorsList to implement the custom ui view delegate
extension VTAVendorsList: VTAVendorsListUIDelegate {
    func userDidTapFilterButton() {
        presenter.userDidTapFilterBtn(self)
    }
    
    // Send Favourite Button Event to Presenter
    func userDidTapFavouriteBtn(_ onItemID: String) {
        presenter.userDidTapFavouriteBtn(self, forObject: onItemID)
    }
}

// MARK: - extending VTAVendorsList to implement the custom ui view data source
extension VTAVendorsList: VTAVendorsListUIDataSource {
    // Pass the pre-defined object to the dataSource.
    func objectFor(view: VTAVendorsListUI) -> Results<ETAVendorsList>? {
        return self.object!
    }
}
