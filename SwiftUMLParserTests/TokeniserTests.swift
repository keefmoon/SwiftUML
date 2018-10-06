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
        
        let expected: [Token] = [.lowercaseLetter(UnicodeScalar("c")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("s")!)]
        let actual: [Token] = self.tokeniser.tokenise("class")
        
        XCTAssert(actual == expected)
    }
    
    func testWlassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.lowercaseLetter(UnicodeScalar("w")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("s")!)]
        let actual: [Token] = self.tokeniser.tokenise("wlass")
        
        XCTAssert(actual == expected)
    }
    
    func testClaswTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.lowercaseLetter(UnicodeScalar("c")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("w")!)]
        let actual: [Token] = self.tokeniser.tokenise("clasw")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_TextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.lowercaseLetter(UnicodeScalar("c")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .whitespace]
        let actual: [Token] = self.tokeniser.tokenise("class ")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_ClassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.lowercaseLetter(UnicodeScalar("c")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .whitespace,
                                 .lowercaseLetter(UnicodeScalar("c")!),
                                 .lowercaseLetter(UnicodeScalar("l")!),
                                 .lowercaseLetter(UnicodeScalar("a")!),
                                 .lowercaseLetter(UnicodeScalar("s")!),
                                 .lowercaseLetter(UnicodeScalar("s")!)]
        let actual: [Token] = self.tokeniser.tokenise("class class")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_AllTokens() {
        
        let expected: [Token] = [.atSymbol,
                                 .hyphen,
                                 .whitespace,
                                 .newLine,
                                 .colon,
                                 .hashSymbol,
                                 .openCurlyBracket,
                                 .closeCurlyBracket,
                                 .openPointyBracket,
                                 .closePointyBracket,
                                 .openSquareBracket,
                                 .closeSquareBracket,
                                 .fullStop,
                                 .simpleQuote,
                                 .doubleQuote,
                                 .slash,
                                 .backSlash,
                                 .pipeSeparator,
                                 .uppercaseLetter(UnicodeScalar("A")!),
                                 .lowercaseLetter(UnicodeScalar("b")!),
                                 .digit(UnicodeScalar("2")!),
                                 .other(UnicodeScalar("&")!)]
        
        let stringToTokenise = """
@- 
:#{}<>[].'\"/\\|Ab2&
"""
        let actual: [Token] = self.tokeniser.tokenise(stringToTokenise)
        XCTAssert(actual == expected)
    }

}
