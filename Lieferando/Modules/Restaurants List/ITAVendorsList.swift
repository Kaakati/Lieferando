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
        
        APIClient.shared.restaurantsList { (result) in
            print(result)
            
            result.forEach({ (res) in
                let restaurant = ETAVendorsList()
                restaurant.name = res.name ?? "N/A"
                restaurant.status = res.status ?? "closed"
                
                RealmHandler.shared.writeToRealm(restaurant)
            })
            self.notificationToken = RealmHandler.shared.realm.observe { [unowned self] note, realm in
                presenter.interactor(self, didFetch: RealmHandler.shared.realm.objects(ETAVendorsList.self))
            }
        }
    }
    
    func filterResults(objectFor presenter: PTAVendorsListProtocol) {
        //
    }
}
