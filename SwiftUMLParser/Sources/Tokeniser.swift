//
//  Tokeniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public final class Tokeniser {
    
    public init() { }
    
    public func tokenise(_ string: String) -> [Token] {
        
        var tokens = [Token]()
        var scalars = string.unicodeScalars
        let recognisers: [TokenRecogniser] = [CharacterSetRecogniser(characterSet: .whitespaces, recognising: .whitespace),
                                              StaticStringRecogniser(stringToMatch: "class", recognising: .classIdentifier)]
        
        while let token = scalars.consumeCharacters(using: recognisers) {
            tokens.append(token)
        }
        
        return tokens
    }
}

// Should be a fileprivate extension
extension String.UnicodeScalarView {
    
    fileprivate mutating func consumeCharacters(using recognisers: [TokenRecogniser]) -> Token? {
        
        for index in self.indices {
            
            let subset = self.suffix(from: index)
            
            for recogniser in recognisers {
                
                if let token = recogniser.attemptRecognition(with: subset) {
                    self = String.UnicodeScalarView(self.suffix(from: self.index(after: index)))
                    return token
                }
            }
        }
        return nil
    }
}
