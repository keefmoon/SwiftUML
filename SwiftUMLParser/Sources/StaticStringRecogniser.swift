//
//  StaticStringRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

final class StaticStringRecogniser: TokenRecogniser {
    
    enum RecognitionState {
        case initial
        case potential
        case failed
        case succeeded
    }
    
    let token: Token
    let stringToMatch: String.UnicodeScalarView
    let patternConclusionSet: CharacterSet
    var currentIndex: String.Index
    var currentState: RecognitionState = .initial
    
    init(stringToMatch: String, patternConclusionSet: CharacterSet = .whitespacesAndNewlines, recognising token: Token) {
        self.stringToMatch = stringToMatch.unicodeScalars
        self.patternConclusionSet = patternConclusionSet
        self.token = token
        self.currentIndex = self.stringToMatch.startIndex
    }
    
    func attemptRecognition(of scalar: UnicodeScalar, withLookAheadScalar lookAheadScalar: UnicodeScalar?) -> Token? {
    
        defer {
            self.currentIndex = self.stringToMatch.index(after: self.currentIndex)
        }
        
        if self.currentIndex >= self.stringToMatch.endIndex {
            self.currentState = .failed
        }
        
        guard self.currentState != .failed else {
            return nil
        }
        
        print("self.currentIndex: \(self.currentIndex)")
        print("endIndex: \(self.stringToMatch.endIndex)")
        
        if scalar == self.stringToMatch[self.currentIndex] {
            
            self.currentState = .potential
            
            let matchedCompletePattern = self.currentIndex == self.stringToMatch.index(before: self.stringToMatch.endIndex)
            let endOfString = lookAheadScalar == nil
            let patternConclusionOnLookAhead: Bool = {
                
                if let lookAhead = lookAheadScalar, self.patternConclusionSet.contains(lookAhead) {
                    return true
                } else {
                    return false
                }
            }()
            
            if matchedCompletePattern && (endOfString || patternConclusionOnLookAhead) {
                
                self.currentState = .succeeded
                self.clear()
                return self.token
                
            } else {
                return nil
            }
            
        } else {
            
            self.currentState = .failed
        }
        
        return nil
    }
    
    func clear() {
        self.currentIndex = self.stringToMatch.startIndex
        self.currentState = .initial
    }
}
