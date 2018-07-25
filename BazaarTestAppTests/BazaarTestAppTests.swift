//
//  BazaarTestAppTests.swift
//  BazaarTestAppTests
//
//  Created by Tara Tandel on 4/17/1397 AP.
//  Copyright © 1397 Tara Tandel. All rights reserved.
//

import XCTest
import SwiftyJSON
import Alamofire

@testable import BazaarTestApp

class BazaarTestAppTests: XCTestCase {
    
    var appUnderTest : ApiHelper!

    override func setUp() {
        super.setUp()
        
        appUnderTest = ApiHelper()
//        appUnderTest.buildList()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        appUnderTest = nil

        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCallToIMDB(){
        // given
        let url = "/search/movie"
        let parameters = ["query" : "batman" as AnyObject, "page" : "1" as AnyObject, "api_key" : "2696829a81b1b5827d515ff121700838" as AnyObject]
        var statuses = true
        var responseError : String?
        let promise  = expectation(description: "Completion handler invoked")
        
        // when
        _ = appUnderTest.sendSimpleGetReq(urlString: url, lstParams: parameters){
            response , status in
                responseError = response["error"]?.string
                statuses = status
            promise.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statuses, false)
        
    }
    func testStatus (){
        // given
        var statuses = false
        var responseError : String?
        let promise  = expectation(description: "Completion handler invoked")

        if let path = Bundle.main.path(forResource: "movie", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //when
                appUnderTest.checkStatus(json: JSON(jsonResult)){
                    response , status in
                    responseError = response["error"]?.string
                    statuses = status
                    promise.fulfill()
                }
            } catch {
                // handle error
            }
        }
        //then
        waitForExpectations(timeout: 6, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statuses, true)
    }
    
    
}
