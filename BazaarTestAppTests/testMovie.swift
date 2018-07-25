//
//  testMovie.swift
//  BazaarTestAppTests
//
//  Created by Tara Tandel on 4/24/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import BazaarTestApp

class testMovie: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovie() {
        // given
        var countOfObjects = 0
        
        if let path = Bundle.main.path(forResource: "movieCount", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //when
                let movies = Movie.buildList(data: JSON(jsonResult))
                countOfObjects = movies.count
            } catch {
                // handle error
            }
        }
        XCTAssertEqual(countOfObjects, 20)


        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
