//
//  LieferandoTests.swift
//  LieferandoTests
//
//  Created by Mohamad Kaakati on 11/7/18.
//  Copyright © 2018 Mohamad Kaakati. All rights reserved.
//

import XCTest

@testable import Lieferando
@testable import Realm
@testable import RealmSwift

class LieferandoTests: XCTestCase {

    var expectations : XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.expectations = self.expectation(description: "Test was finished.")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRestaurantsFetch() {
        APIClient.shared.restaurantsList { (results) in
            if results.count > 0 {
                XCTAssertTrue(true, "Success Fetch Details From API")
                self.expectations?.fulfill()
            } else {
                XCTAssertFalse(true, "Fail Fetch Details From API")
                self.expectations?.fulfill()
            }
        }
        
        wait(for: [self.expectations!], timeout: 5)
    }
    
    func testMethods() {
        var results : Results<ETAVendorsList>?
        let view : VTAVendorsListProtocol = VTAVendorsList()
        let interactor : ITAVendorsListProtocol = ITAVendorsList()
        let presenter : PTAVendorsListProtocol = PTAVendorsList(view: view)
        
        let queryString = "status"
        
        results = RealmHandler.shared.realm.objects(ETAVendorsList.self)
        
        presenter.fetch(objectFor: view)
        interactor.fetch(objectFor: presenter)
        presenter.userSearchEvent(queryString)
        presenter.interactor(interactor, didFetch: results)
        
        if results != nil && results!.count < 1 {
            XCTAssertFalse(false, "Realm Database is Empty.")
            self.expectations?.fulfill()
        } else {
            XCTAssertTrue(true, "Success, Realm is not Empty.")
            self.expectations?.fulfill()
        }

        wait(for: [self.expectations!], timeout: 10)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
