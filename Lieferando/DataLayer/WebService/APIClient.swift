//
//  APIClient.swift
//  Lieferando
//
//  Created by Mohamad Kaakati on 11/5/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

enum Endpoints {
    case baseURL
    case restaurantsList
    
    var stringUrl : String {
        switch self {
        case .baseURL:
            #if DEBUG
            return "https://www.kaakati.me/takeaway/" // Staging Environment
            #else
            return "https://www.kaakati.me/takeaway/" // Production Environment
            #endif
        case .restaurantsList:
            return "/list.json"
        }
    }
}

class APIClient {
    
    static let shared = APIClient()
    init(){}
    
    /// Fetch The List of Restaurants
    func restaurantsList(completion : @escaping Restaurants) {
        let url = URL(string: Endpoints.baseURL.stringUrl + Endpoints.restaurantsList.stringUrl)!
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
