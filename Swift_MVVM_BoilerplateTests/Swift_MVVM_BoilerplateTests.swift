//
//  Swift_MVVM_BoilerplateTests.swift
//  Swift_MVVM_BoilerplateTests
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import XCTest
@testable import Swift_MVVM_Boilerplate

class SwiftMVVMBoilerplateTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let loginVM = LoginViewModel()
        loginVM.validateInput("abcdef@fgh.ijk", password: "123456") { (success, message) in
            XCTAssertTrue(success)
            XCTAssertEqual(message, nil)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
