//
//  CharacterSetRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 05/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import Foundation

struct CharacterSetRecogniser: TokenRecogniser {
    
    typealias TokenMatchHandler = (UnicodeScalar) -> Token
    
    let characterSet: CharacterSet
    let matchingHandler: TokenMatchHandler
    
    init(characterSet: CharacterSet, whenMatched matchingHandler: @escaping TokenMatchHandler) {
        self.characterSet = characterSet
        self.matchingHandler = matchingHandler
    }
    
    func attemptRecognition(with scalar: UnicodeScalar) -> Token? {
        return characterSet.contains(scalar) ? self.matchingHandler(scalar) : nil
    }
}
