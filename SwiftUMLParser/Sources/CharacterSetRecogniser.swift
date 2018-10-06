//
//  CharacterSetRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 05/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import Foundation

final class CharacterSetRecogniser: TokenRecogniser {
    
    typealias TokenMatchHandler = (String) -> Token
    
    let includeSet: CharacterSet
    let patternConclusionSet: CharacterSet
    let matchingHandler: TokenMatchHandler
    var recognisedScalars = String.UnicodeScalarView([])
    
    init(includeSet: CharacterSet, patternConclusionSet: CharacterSet = .whitespaces, whenMatched matchingHandler: @escaping TokenMatchHandler) {
        self.includeSet = includeSet
        self.patternConclusionSet = patternConclusionSet
        self.matchingHandler = matchingHandler
    }
    
    func attemptRecognition(of scalar: UnicodeScalar, withLookAheadScalar lookAheadScalar: UnicodeScalar?) -> Token? {
    
        if includeSet.contains(scalar) {
            
            recognisedScalars.append(scalar)
            
            let endOfString = lookAheadScalar == nil
            let patternConclusion: Bool = {
                
                if let lookAhead = lookAheadScalar, patternConclusionSet.contains(lookAhead) {
                    return true
                } else {
                    return false
                }
            }()
            
            if endOfString || patternConclusion {
                return self.matchingHandler(String(recognisedScalars))
            } else {
                return nil
            }
            
        } else {
            
            self.clear()
            return nil
        }
    }
    
    func clear() {
        recognisedScalars.removeAll()
    }
}
