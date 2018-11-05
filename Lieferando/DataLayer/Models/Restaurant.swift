//
//  Restaurant.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

typealias Restaurants = ( [Restaurant]) -> Void

struct Restaurant : Codable {
    var name : String?
    var status : String?
    var sortingValues : SortingValues?
    
    enum CodingKeys : String, CodingKey {
        case name
        case status
        case sortingValues
    }
}

struct SortingValues : Codable {
    var bestMatch : Double?
    var newest : Double?
    var ratingAverage : Double?
    var distance : Int?
    var popularity : Double?
    var averageProductPrice : Int?
    var deliveryCosts : Int?
    var minCost : Int?
}
