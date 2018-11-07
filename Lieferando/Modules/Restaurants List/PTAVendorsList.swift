//
//  PTAVendorsList.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

/// TAVendorsList Module Presenter
class PTAVendorsList {

    weak private var view: VTAVendorsListProtocol?
    private var interactor: ITAVendorsListProtocol
    private var wireframe: RTAVendorsListProtocol

    init(view: VTAVendorsListProtocol) {
        self.view = view
        self.interactor = ITAVendorsList()
        self.wireframe = RTAVendorsList()
        view.setNavigationBarTitleWith("Restaurants List")
        //
        let filterBtn = UIBarButtonItem(image: UIImage(named: "ic_filter"),
                                        style: .plain, target: self,
                                        action: #selector(filterAction))
        view.setupNavigationItem(filterBtn)
    }
}

// MARK: - extending PTAVendorsList to implement it's protocol
extension PTAVendorsList: PTAVendorsListProtocol {
    
    func userSearchEvent(_ stringValue: String) {
        //
        interactor.userSearchEvent(stringValue)
    }
    

    func userDidTapFilterBtn(_ onView: VTAVendorsListProtocol) {
        self.filterAction()
    }

    // Send Favourite Button Even to Interactor
    func userDidTapFavouriteBtn(_ onView: VTAVendorsListProtocol, forObject id: String) {
        interactor.userDidTapFavouriteBtn(self, forObject: id)
    }
    
    func fetch(objectFor view: VTAVendorsListProtocol) {
        // Inform The Interactor to Fetch Objects for This Protocol
        interactor.fetch(objectFor: self)
    }
    
    func interactor(_ interactor: ITAVendorsListProtocol, didFetch object: Results<ETAVendorsList>?) {
        // Set the Object on the View.
        view?.set(object: object)
    }
    
    func interactor(_ interactor: ITAVendorsListProtocol, didFailWith error: Error) {
        // Handle the failure message.
    }
    
    func viewDidFilterResults(_ interactor: ITAVendorsListProtocol) {
        interactor.filterResults(objectFor: self)
    }
    
    @objc func filterAction() {
        print("filter")
        view?.shouldOpenFilters(view!)
    }

}
