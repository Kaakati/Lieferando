//
//  ITAVendorsList.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

/// TAVendorsList Module Interactor
class ITAVendorsList: ITAVendorsListProtocol {

    // Realm ObservationToken
    var notificationToken: NotificationToken?
    
    // Might Need the Presenter for private functions.
    var presenter : PTAVendorsListProtocol?
    
    func fetch(objectFor presenter: PTAVendorsListProtocol) {
        self.presenter = presenter
        
        // Make API Call to Fetch Results
        APIClient.shared.restaurantsList { (result) in
//            print(result)
            
            // Iterate on each and create a new realm object.
            result.forEach({ (res) in
                let restaurant = ETAVendorsList()
                let sortingValues = ETASortingValues()
                
                restaurant.name = res.name ?? "N/A"
                restaurant.status = res.status ?? "closed"
                
                sortingValues.ratingAverage = res.sortingValues?.ratingAverage ?? 0.0
                sortingValues.bestMatch = res.sortingValues?.bestMatch ?? 0
                sortingValues.deliveryCosts = res.sortingValues?.deliveryCosts ?? 0
                sortingValues.distance = res.sortingValues?.distance ?? 0
                sortingValues.popularity = res.sortingValues?.popularity ?? 0
                sortingValues.newest = res.sortingValues?.newest ?? 0
                sortingValues.minCost = res.sortingValues?.minCost ?? 0
                
                restaurant.sortingValues = sortingValues
                
                // Perform Realm Write Transaction.
                RealmHandler.shared.writeToRealm(restaurant)
            })
            
            // Inform Realm of the Change
            self.notificationToken = RealmHandler.shared.realm.observe { [unowned self] note, realm in
                let restaurants = RealmHandler.shared.realm.objects(ETAVendorsList.self)
                presenter.interactor(self, didFetch: restaurants
                    .sorted(byKeyPath: "status", ascending: false)
                    .sorted(byKeyPath: "isFavourite", ascending: false)
                )
            }
        }
    }
    
    func userSearchEvent(_ stringValue: String) {
        // Inform Realm of the Change
        let restaurants = RealmHandler.shared.realm.objects(ETAVendorsList.self)
        if !stringValue.isEmpty {
            presenter!.interactor(self, didFetch: restaurants
                .filter("name CONTAINS '\(stringValue)'")
                .sorted(byKeyPath: "\(stringValue.camelCased)", ascending: false)
                .sorted(byKeyPath: "status", ascending: false)
                .sorted(byKeyPath: "isFavourite", ascending: false)
            )
        } else {
            presenter!.interactor(self, didFetch: restaurants
                .sorted(byKeyPath: "status", ascending: false)
                .sorted(byKeyPath: "isFavourite", ascending: false)
            )
        }
    }
    
    func filterResults(objectFor presenter: PTAVendorsListProtocol) {
        //
    }
    
    func userDidTapFavouriteBtn(_ presenter: PTAVendorsListProtocol, forObject id: String) {
        //
        let restaurant = RealmHandler.shared.realm.objects(ETAVendorsList.self).filter("id == %@", id).first!
        try! RealmHandler.shared.realm.write {
            restaurant.isFavourite = !restaurant.isFavourite
        }
    }
    
    // Sorting
    func sortingResults(_ presenter: PTAVendorsListProtocol, filterType: AvailableSortings) {

        switch filterType {
        case .reset:
            print("User Selected: \(filterType.sorting!)")
            let restaurants = RealmHandler.shared.realm.objects(ETAVendorsList.self)
            self.presenter!.interactor(self, didFetch: restaurants
                .sorted(byKeyPath: "status", ascending: false)
                .sorted(byKeyPath: "isFavourite", ascending: false)
            )
        case .status:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .rating:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .popularity:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .minimumCost:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .favourite:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .distance:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .deliveryCost:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .bestMatch:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .avgPrice:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        case .newest:
            print("User Selected: \(filterType.sorting!)")
            sortingMethod(filterType.sorting!)
        }
    }
    
    private func sortingMethod(_ sortingString : String) {
        let restaurants = RealmHandler.shared.realm.objects(ETAVendorsList.self)
        presenter!.interactor(self, didFetch: restaurants
            .sorted(byKeyPath: "status", ascending: false)
            .sorted(byKeyPath: "\(sortingString)", ascending: true)
            .sorted(byKeyPath: "isFavourite", ascending: false)
        )
    }
}
