//
//  CharacterSet+All.swift
//  SwiftUMLParser
//
//  Created by Keith Moon on 06/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import Foundation

extension CharacterSet {
    
    static var all: CharacterSet {
        return CharacterSet.alphanumerics.union(CharacterSet.alphanumerics.inverted)
    }
    
    static var plantUMLIdentifierAllowed: CharacterSet {
        return (CharacterSet(charactersIn: "{}<>").union(.whitespacesAndNewlines)).inverted
    }
}
