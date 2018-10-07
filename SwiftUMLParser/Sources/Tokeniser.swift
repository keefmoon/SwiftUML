//
//  Tokeniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public final class Tokeniser {
    
    let recognisers: [TokenRecogniser]
    
    public convenience init() {
        
        let whitespace = CharacterSetRecogniser(includeSet: .whitespaces, patternConclusionSet: CharacterSet.whitespaces.inverted, whenMatched: { _ in .whitespace })
        let newline = CharacterSetRecogniser(includeSet: .newlines, patternConclusionSet: .all, whenMatched: { _ in .newline })
        let openCurlyBracket = StaticStringRecogniser(stringToMatch: "{", recognising: .openCurlyBracket)
        let closeCurlyBracket = StaticStringRecogniser(stringToMatch: "}", recognising: .closeCurlyBracket)
        let startUML = StaticStringRecogniser(stringToMatch: "@startuml", recognising: .startUML)
        let endUML = StaticStringRecogniser(stringToMatch: "@enduml", recognising: .endUML)
        let startMultiLineComment = StaticStringRecogniser(stringToMatch: "/'", patternConclusionSet: .all, recognising: .startMultiLineComment)
        let endMultiLineComment = StaticStringRecogniser(stringToMatch: "'/", patternConclusionSet: .all, recognising: .endMultiLineComment)
        
        
        let classKeyword = StaticStringRecogniser(stringToMatch: "class", recognising: .classIdentifier)
        
        let identifierString = CharacterSetRecogniser(includeSet: .plantUMLIdentifierAllowed,
                                                      patternConclusionSet: CharacterSet.plantUMLIdentifierAllowed.inverted) { matchedString -> Token in
                                                        
                                                        return .identifier(matchedString)
        }
        
        let recognisers: [TokenRecogniser] = [whitespace,
                                              newline,
                                              openCurlyBracket,
                                              closeCurlyBracket,
                                              startUML,
                                              endUML,
                                              startMultiLineComment,
                                              endMultiLineComment,
                                              classKeyword,
                                              identifierString]
        
        self.init(recognisers: recognisers)
    }
    
    init(recognisers: [TokenRecogniser]) {
        
        self.recognisers = recognisers
    }
    
    public func tokenise(_ string: String) -> [Token] {
        
        var tokens = [Token]()
        var scalars = string.unicodeScalars
        
        while let token = scalars.consumeCharacters(using: self.recognisers) {
            tokens.append(token)
        }
        
        return tokens
    }
}

// Should be a fileprivate extension
extension String.UnicodeScalarView {
    
    fileprivate mutating func consumeCharacters(using recognisers: [TokenRecogniser]) -> Token? {
        
        for index in self.indices {
            
            let firstScalar = self[index]
            let lookAheadScalar = index == self.index(before: self.endIndex) ? nil : self[self.index(after: index)]
            
            var nextToken: Token?
            
            for recogniser in recognisers {
                
                guard nextToken == nil else {
                    recogniser.clear()
                    continue
                }
                
                if let token = recogniser.attemptRecognition(of: firstScalar, withLookAheadScalar: lookAheadScalar) {
                    
                    self = String.UnicodeScalarView(self.suffix(from: self.index(after: index)))
                    nextToken = token
                }
            }
            
            if let token = nextToken {
                return token
            }
        }
        return nil
    }
}
