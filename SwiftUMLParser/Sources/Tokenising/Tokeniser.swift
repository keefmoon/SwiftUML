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
        self.init(recognisers:  Token.allRecognisers)
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
                
                if let token = recogniser.attemptRecognition(of: firstScalar, withLookAheadScalar: lookAheadScalar) {
                    
                    self = String.UnicodeScalarView(self.suffix(from: self.index(after: index)))
                    nextToken = token
                    
                    // Reset all the recognisers
                    recognisers.forEach { $0.clear() }
                    break
                }
            }
            
            if let token = nextToken {
                return token
            }
        }
        return nil
    }
}
