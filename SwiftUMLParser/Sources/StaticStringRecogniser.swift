//
//  StaticStringRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

final class StaticStringRecogniser: TokenRecogniser {
    
    let token: Token
    let stringToMatch: String.UnicodeScalarView
    let patternConclusionSet: CharacterSet
    var matchedIndex: String.Index?
    
    init(stringToMatch: String, patternConclusionSet: CharacterSet = .whitespaces, recognising token: Token) {
        self.stringToMatch = stringToMatch.unicodeScalars
        self.patternConclusionSet = patternConclusionSet
        self.token = token
    }
    
    func attemptRecognition(of scalar: UnicodeScalar, withLookAheadScalar lookAheadScalar: UnicodeScalar?) -> Token? {
    
        let indexToCheck: String.Index = {
            
            if let lastMatchedIndex = self.matchedIndex {
                return self.stringToMatch.index(after: lastMatchedIndex)
            } else {
                return self.stringToMatch.startIndex
            }
        }()
        
        guard indexToCheck < self.stringToMatch.endIndex else {
            self.clear()
            return nil
        }
        
        if scalar == stringToMatch[indexToCheck] {
            
            self.matchedIndex = indexToCheck
            
            let matchedCompletePattern = indexToCheck == self.stringToMatch.index(before: self.stringToMatch.endIndex)
            let endOfString = lookAheadScalar == nil
            let patternConclusionOnLookAhead: Bool = {
                
                if let lookAhead = lookAheadScalar, patternConclusionSet.contains(lookAhead) {
                    return true
                } else {
                    return false
                }
            }()
            
            if matchedCompletePattern && (endOfString || patternConclusionOnLookAhead) {
                
                self.clear()
                return self.token
                
            } else {
                return nil
            }
        }
        self.clear()
        return nil
    }
    
    func clear() {
        self.matchedIndex = nil
    }
}
