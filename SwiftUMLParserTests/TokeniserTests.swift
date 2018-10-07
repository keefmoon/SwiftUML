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
        
        let expected: [Token] = [.class]
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
        
        let expected: [Token] = [.class, .whitespace]
        let actual: [Token] = self.tokeniser.tokenise("class ")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_ClassTextIsTokenisedCorrectly() {
        
        let expected: [Token] = [.class, .whitespace, .class]
        let actual: [Token] = self.tokeniser.tokenise("class class")
        
        XCTAssert(actual == expected)
    }
    
    func testClass_ClassBracketsWhiteAndNewLineIsTokenisedCorrectly() {
        
        let expected: [Token] = [.class, .whitespace, .openCurlyBracket, .newline, .whitespace, .class, .newline, .closeCurlyBracket]
        
        let text = """
class {
    class
}
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testNewLineThenClassIsTokenisedCorrectly() {
        
        let expected: [Token] = [.class, .whitespace, .openCurlyBracket, .newline, .class, .newline, .closeCurlyBracket]
        
        let text = """
class {
class
}
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testClassExampleWithIdentifierIsTokenisedCorrectly() {
        
        let expected: [Token] = [.class,
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
    
    func testDoubleHyphenIsTokenisedCorrectly() {
        
        let expected: [Token] = [.hyphen, .hyphen]
        
        let text = "--"
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testDoubleHyphenInSituWrongOrderIsTokenisedCorrectly() {
        
        let expected: [Token] = [.startUML,
                                 .newline,
                                 .identifier("Class01"),
                                 .whitespace,
                                 .openPointyBracket,
                                 .pipe,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class02")]
        
        let hyphenTokeniser = Tokeniser(recognisers: [Token.startUML.recogniser,
                                                      Token.whitespace.recogniser,
                                                      Token.newline.recogniser,
                                                      Token.openPointyBracket.recogniser,
                                                      Token.pipe.recogniser,
                                                      Token.star.recogniser,
                                                      Token.hyphen.recogniser,
                                                      Token.identifier("_").recogniser])
        
        let text = """
@startuml
Class01 <|-- Class02
"""
        let actual: [Token] = hyphenTokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testDoubleHyphenInSituRightOrderIsTokenisedCorrectly() {
        
        let expected: [Token] = [.startUML,
                                 .newline,
                                 .identifier("Class01"),
                                 .whitespace,
                                 .openPointyBracket,
                                 .pipe,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class02")]
        
        let hyphenTokeniser = Tokeniser(recognisers: [Token.whitespace.recogniser,
                                                      Token.newline.recogniser,
                                                      Token.openPointyBracket.recogniser,
                                                      Token.hyphen.recogniser,
                                                      Token.pipe.recogniser,
                                                      Token.star.recogniser,
                                                      Token.startUML.recogniser,
                                                      Token.identifier("_").recogniser])
        
        let text = """
@startuml
Class01 <|-- Class02
"""
        let actual: [Token] = hyphenTokeniser.tokenise(text)
        
        XCTAssert(actual == expected)
    }
    
    func testArrowTypesIsTokenisedCorrectly() {
        
        let expected: [Token] = [.startUML,
                                 
                                 .newline,
                                 .identifier("Class01"),
                                 .whitespace,
                                 .openPointyBracket,
                                 .pipe,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class02"),
                                 
                                 .newline,
                                 .identifier("Class03"),
                                 .whitespace,
                                 .star,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class04"),
                                 
                                 .newline,
                                 .identifier("Class05"),
                                 .whitespace,
                                 .o,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class06"),
                                 
                                 .newline,
                                 .identifier("Class07"),
                                 .whitespace,
                                 .fullStop,
                                 .fullStop,
                                 .whitespace,
                                 .identifier("Class08"),
                                 
                                 .newline,
                                 .identifier("Class09"),
                                 .whitespace,
                                 .hyphen,
                                 .hyphen,
                                 .whitespace,
                                 .identifier("Class10"),
                                 
                                 .newline,
                                 .identifier("Class11"),
                                 .whitespace,
                                 .openPointyBracket,
                                 .pipe,
                                 .fullStop,
                                 .fullStop,
                                 .whitespace,
                                 .identifier("Class12"),
                                 
                                 .newline,
                                 .identifier("Class13"),
                                 .whitespace,
                                 .hyphen,
                                 .hyphen,
                                 .closePointyBracket,
                                 .whitespace,
                                 .identifier("Class14"),
                                 
                                 .newline,
                                 .identifier("Class15"),
                                 .whitespace,
                                 .fullStop,
                                 .fullStop,
                                 .closePointyBracket,
                                 .whitespace,
                                 .identifier("Class16"),
                                 
                                 .newline,
                                 .identifier("Class17"),
                                 .whitespace,
                                 .fullStop,
                                 .fullStop,
                                 .pipe,
                                 .closePointyBracket,
                                 .whitespace,
                                 .identifier("Class18"),
                                 
                                 .newline,
                                 .identifier("Class19"),
                                 .whitespace,
                                 .openPointyBracket,
                                 .hyphen,
                                 .hyphen,
                                 .star,
                                 .whitespace,
                                 .identifier("Class20"),
                                 
                                 .newline,
                                 .endUML]
        
        let text = """
@startuml
Class01 <|-- Class02
Class03 *-- Class04
Class05 o-- Class06
Class07 .. Class08
Class09 -- Class10
Class11 <|.. Class12
Class13 --> Class14
Class15 ..> Class16
Class17 ..|> Class18
Class19 <--* Class20
@enduml
"""
        let actual: [Token] = self.tokeniser.tokenise(text)
        
        for index in actual.indices {
            
            let a = actual[index]
            let e = expected[index]
            let result = a == e ? "PASS" : "FAIL"
            print("\(result) | Actual: \(a) | Expected: \(e)")
        }
        
        XCTAssert(actual == expected)
        
    }
}
