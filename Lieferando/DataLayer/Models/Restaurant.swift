//
//  Restaurant.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/4/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import Foundation

struct Restaurant : Codable {
    var name : String?
    var sortingValues : SortingValues?
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
