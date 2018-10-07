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
    
    func testWclassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.identifier("wclass")]
        let actual: [Token] = self.tokeniser.tokenise("wclass")
        
        XCTAssert(actual == expected)
    }
    
    func testClasswTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.identifier("classw")]
        let actual: [Token] = self.tokeniser.tokenise("classw")
        
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
    
    func testClass_ClassBracketsWhiteAndNewLineIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier, .whitespace, .openCurlyBracket, .newline, .whitespace, .classIdentifier, .newline, .closeCurlyBracket]
        
        let text = """
class {
    class
}
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testNewLineThenClassIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier, .whitespace, .openCurlyBracket, .newline, .classIdentifier, .newline, .closeCurlyBracket]
        
        let text = """
class {
class
}
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testClassExampleWithIdentifierIsTokenisedCorrectly() {
        
        let expected: [Token] = [.classIdentifier,
                                 .whitespace,
                                 .identifier("MyClass"),
                                 .whitespace,
                                 .openCurlyBracket,
                                 .newline,
                                 .whitespace,
                                 .identifier("someIdentifier"),
                                 .newline,
                                 .closeCurlyBracket]
        
        let text = """
class MyClass {
    someIdentifier
}
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
}
