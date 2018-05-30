//
//  ToDoMVCTests.swift
//  ToDoMVCTests
//
//  Created by wangyan on 2018/5/29.
//  Copyright © 2018年 wangyan. All rights reserved.
//

import XCTest
@testable import ToDoMVC
import ObjectMapper
import PromiseKit

class ToDoMVCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetService() {
    
        let expectation = self.expectation(description: "")
        let timeout = 30 as TimeInterval
        
        ToDoStore.shared.getAlItems().done { (items) in
        
            print(items)
            expectation.fulfill()
        }
        
//        NetworkServie.shared.request(url: "https://leancloud.cn:443/1.1/classes/HXAPPNetworkMOCK?where={\"apiName\":\"items\"}")
//            .done { (bean) in
//
//                print(bean!.data)
//                expectation.fulfill()
//            }.catch { (e) in
//                print(e)
//        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
