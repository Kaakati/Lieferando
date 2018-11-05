//
//  ETAVendorsList.swift
//  Lieferando
//
//  Created Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

/// TAVendorsList Module Entity
class ETAVendorsList : Object {
    
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var name : String = ""
    @objc dynamic var isFavourite : Bool = false
    @objc dynamic var status : String = ""
    var sortingValues = List<ETASortingValues>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class ETASortingValues : Object {
    
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var bestMatch : Double = 0.0
    @objc dynamic var newest : Double = 0.0
    @objc dynamic var ratingAverage : Double = 0.0
    @objc dynamic var distance : Int = 0
    @objc dynamic var popularity : Double = 0.0
    @objc dynamic var averageProductPrice : Int = 0
    @objc dynamic var deliveryCosts : Int = 0
    @objc dynamic var minCost : Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
