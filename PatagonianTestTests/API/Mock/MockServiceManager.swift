//
//  MockServiceManager.swift
//  PatagonianTestTests
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import XCTest
@testable import PatagonianTest

class MockServiceManager: XCTestCase {
    
    var shouldReturnError = false
    var requestRetrieveDataWasCalled = false
    
    func reset() {
        shouldReturnError = false
        requestRetrieveDataWasCalled = false
     //   mockData = try? JSONSerialization.data(withJSONObject: mockJson)
        
    }
    
    var mockData = LyricModel(artist: "coldplay", song: "clocks", lyrics: "ahhhh")
  
    
}

extension MockServiceManager: ServiceManagerProtocol {
    func searchLyric(stringUrl: String, success: @escaping (LyricModel) -> (), fail: @escaping (ErrorService) -> Void) {
        if shouldReturnError {
            fail(ErrorService.notFound)
        } else {
            success(mockData)
        }
    }
}


