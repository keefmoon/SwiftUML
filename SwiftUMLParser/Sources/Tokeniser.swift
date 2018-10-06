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
        self.init(recognisers: [CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "@"), whenMatched: { _ in .atSymbol }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "-"), whenMatched: { _ in .hyphen }),
                                CharacterSetRecogniser(characterSet: .whitespaces, whenMatched: { _ in .whitespace }),
                                CharacterSetRecogniser(characterSet: .newlines, whenMatched: { _ in .newLine }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: ":"), whenMatched: { _ in .colon }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "#"), whenMatched: { _ in .hashSymbol }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "{"), whenMatched: { _ in .openCurlyBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "}"), whenMatched: { _ in .closeCurlyBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "<"), whenMatched: { _ in .openPointyBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: ">"), whenMatched: { _ in .closePointyBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "["), whenMatched: { _ in .openSquareBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "]"), whenMatched: { _ in .closeSquareBracket }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "."), whenMatched: { _ in .fullStop }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "'"), whenMatched: { _ in .simpleQuote }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "\""), whenMatched: { _ in .doubleQuote }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "/"), whenMatched: { _ in .slash }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "\\"), whenMatched: { _ in .backSlash }),
                                CharacterSetRecogniser(characterSet: CharacterSet(charactersIn: "|"), whenMatched: { _ in .pipeSeparator }),
                                CharacterSetRecogniser(characterSet: .symbols, whenMatched: { .otherSymbol($0) }),
                                CharacterSetRecogniser(characterSet: .uppercaseLetters, whenMatched: { .uppercaseLetter($0) }),
                                CharacterSetRecogniser(characterSet: .lowercaseLetters, whenMatched: { .lowercaseLetter($0) }),
                                CharacterSetRecogniser(characterSet: .decimalDigits, whenMatched: { .digit($0) }),
                                CharacterSetRecogniser(characterSet: CharacterSet.letters.inverted, whenMatched: { .other($0) })])
    }
    
    init(recognisers: [TokenRecogniser]) {
        self.recognisers = recognisers
    }
    
    public func tokenise(_ string: String) -> [Token] {
        
        let recognisers = self.recognisers
        return string.unicodeScalars.compactMap { scalar in
            
            for recogniser in recognisers {
                
                if let token = recogniser.attemptRecognition(with: scalar) {
                    return token
                }
            }
            return nil
        }
    }
}
