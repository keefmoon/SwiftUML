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
    var matchedIndex: String.Index?
    
    init(stringToMatch: String, recognising token: Token) {
        self.stringToMatch = stringToMatch.unicodeScalars
        self.token = token
    }
    
    func attemptRecognition(with scalarView: Substring.UnicodeScalarView) -> Token? {
        
        let indexToCheck: String.Index = {
           
            if let lastMatchedIndex = self.matchedIndex {
                return self.stringToMatch.index(after: lastMatchedIndex)
            } else {
                return self.stringToMatch.startIndex
            }
        }()
        
        guard indexToCheck < self.stringToMatch.endIndex else {
            self.reset()
            return nil
        }
        
        if scalarView[scalarView.startIndex] == stringToMatch[indexToCheck] {
            self.matchedIndex = indexToCheck
            if indexToCheck == self.stringToMatch.index(before: self.stringToMatch.endIndex) {
                self.reset()
                return self.token
            } else {
                return nil
            }
        }
        self.reset()
        return nil
    }
    
    func reset() {
        self.matchedIndex = nil
    }
}
