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

extension Restaurant {
    
    /*
     Usually This is called from an API Class,
     but since we have one Endpoint,
     I'll leave it here within the Model.
    */
    
    /// Fetch The List of Restaurants
    static func list(completion : @escaping Restaurants) {
        let url = URL(string: "https://www.kaakati.me/takeaway/list.json")!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date. // If There is a Date.
        
        Alamofire.request(url).responseDecodableObject(keyPath: "restaurants", decoder: decoder) { (response: DataResponse<[Restaurant]>) in
            guard let result = response.result.value else {
                return
            }
            completion(result)
        }
    }
}
