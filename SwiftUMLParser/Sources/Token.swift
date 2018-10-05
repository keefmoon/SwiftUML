//
//  Token.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public enum Token {
    case whitespace
    case openBracket
    case closeBracket
    case classIdentifier
    case other(String)
}

extension Token: Equatable {
    
}
