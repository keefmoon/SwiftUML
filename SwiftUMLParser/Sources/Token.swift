//
//  Token.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public enum Token {
    case atSymbol // @
    case hyphen // -
    case whitespace //
    case newLine // \n
    case colon // :
    case hashSymbol // #
    case openCurlyBracket // {
    case closeCurlyBracket // }
    case openPointyBracket // <
    case closePointyBracket // >
    case openSquareBracket // [
    case closeSquareBracket // ]
    case fullStop // .
    case simpleQuote // '
    case doubleQuote // "
    case slash // /
    case backSlash // \
    case pipeSeparator // |
    
    case otherSymbol(UnicodeScalar)
    case uppercaseLetter(UnicodeScalar)
    case lowercaseLetter(UnicodeScalar)
    case digit(UnicodeScalar)
    case other(UnicodeScalar)
}

extension Token: Equatable {
    
}
