//
//  TestServiceManager.swift
//  PatagonianTestTests
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//


import XCTest
@testable import PatagonianTest

class TestServiceManager: XCTestCase {
    private let endPoint = Constants.BaseURL.endpoint
    
    //testing real APIClient
    //let retrieveApiClient = ServiceManager()
    
    //testing mock APIClient
    let retrieveApiClient = MockServiceManager()
    
    func testRetrieveData() {
        //uncomment the following two lines, when mock test is used.
        retrieveApiClient.reset()
        retrieveApiClient.shouldReturnError = false
        
        let expectation = self.expectation(description: "I expect to receive Data")
        
        retrieveApiClient.searchLyric(stringUrl: endPoint, success: { (lyric) in

            if lyric.lyrics.isEmpty {
                XCTFail()
                return
            }
            
            print(lyric)
            XCTAssertNotNil(lyric)
            expectation.fulfill()
        }) { (error) in
            XCTAssertNil(error)
               
        }
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}


