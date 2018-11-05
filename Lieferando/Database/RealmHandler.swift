//
//  RealmHandler.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmHandler {
    
    static let shared = RealmHandler()
    init(){}
    
    let realm = try! Realm()
    
    /// Save The Object to Realm
    func writeToRealm<T: Object>(_ object: T) {
        // Write Transactions Should Always be on the main thread.
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.add(object, update: true)
            }
        }
    }

}
