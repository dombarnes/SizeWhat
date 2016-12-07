//
//  ItemTests.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 07/12/2016.
//  Copyright © 2016 Trilby Multimedia Limited. All rights reserved.
//

import UIKit
import XCTest

class ItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  func testItemInitialization() {
    // Success case
    let potentialItem = Item(name: "First Item", description: "This is an item", type: "", roomName: "Front room")
    XCTAssertNotNil(potentialItem)
    
    // Fail cases
    let noName = Item(name: "", description: "This is an item", type: "", roomName: "Front room")
    XCTAssertNil(noName, "Empty name is invalid")
  }
}
