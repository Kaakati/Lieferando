//
//  RestaurantEntity.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RestaurantEntity : Object {
    
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var name : String = ""
    @objc dynamic var isFavourite : Bool = false
    @objc dynamic var status : String = ""
    var sortingValues = List<sortingValues>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class sortingValues : Object {
    
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
