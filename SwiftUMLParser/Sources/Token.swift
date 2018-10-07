//
//  Token.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public enum Token {
    case whitespace
    case newline
    case openCurlyBracket // {
    case closeCurlyBracket // }
    case simpleQuote // '
    case doubleQuote // "
    case startMultiLineComment // /'
    case endMultiLineComment // '/
    case startUML
    case endUML
    
    case classIdentifier
    case identifier(String)
}

extension Token: Equatable {
    
}
