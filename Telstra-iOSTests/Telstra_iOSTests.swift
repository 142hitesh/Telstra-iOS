//
//  Telstra_iOSTests.swift
//  Telstra-iOSTests
//
//  Created by Hitesh on 6/29/18.
//  Copyright © 2018 Hitesh. All rights reserved.
//

import XCTest
@testable import Telstra_iOS

class Telstra_iOSTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testCalltoCountryDataCompletes() {
        // given
        let url = URL(string: countryEndPoint)
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testJSONDecoding() {
        //given
        let json = """
        {
            "title":"About Canada",
            "rows":[
                {
                    "title":"Beavers",
                    "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                    "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        //when
        let country = try? JSONDecoder().decode(Country.self, from: json)
        
        //then
        XCTAssertEqual(country?.title, "About Canada")
        XCTAssertEqual(country?.facts.count, 1, "Facts count should be 1")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
