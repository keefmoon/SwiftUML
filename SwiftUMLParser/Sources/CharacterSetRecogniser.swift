//
//  CharacterSetRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 05/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import Foundation

final class CharacterSetRecogniser: TokenRecogniser {
    
    let token: Token
    let characterSet: CharacterSet
    
    init(characterSet: CharacterSet, recognising token: Token) {
        self.characterSet = characterSet
        self.token = token
    }
    
    func attemptRecognition(with scalarView: Substring.UnicodeScalarView) -> Token? {
        return characterSet.contains(scalarView[scalarView.startIndex]) ? self.token : nil
    }
}
