//
//  TokeniserTests.swift
//  SwiftUMLParserTests
//
//  Created by Keith Moon on 05/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import XCTest
@testable import SwiftUMLParser

class TokeniserTests: XCTestCase {

    var tokeniser: Tokeniser!
    
    override func setUp() {
        
        self.tokeniser = Tokeniser()
    }

    override func tearDown() {
        
        self.tokeniser = nil
    }

    func testClassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier]
        let actual: [Token] = self.tokeniser.tokenise("class")
        
        XCTAssert(actual == expected)
    }
    
    func testWlassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = []
        let actual: [Token] = self.tokeniser.tokenise("wlass")
        
        XCTAssert(actual == expected)
    }
    
    func testClaswTextIsTokenisedCorrectly() {
        
        let expected: [Token] = []
        let actual: [Token] = self.tokeniser.tokenise("clasw")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_TextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier, .whitespace]
        let actual: [Token] = self.tokeniser.tokenise("class ")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_ClassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier, .whitespace, .classIdentifier]
        let actual: [Token] = self.tokeniser.tokenise("class class")
        
        XCTAssert(actual == expected)
    }

}
