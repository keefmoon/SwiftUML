//
//  Token.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

public enum Token {
    
    // Whitespace and New Lines
    case whitespace
    case newline
    
    // Brackets
    case openCurlyBracket // {
    case closeCurlyBracket // }
    case openPointyBracket // <
    case closePointyBracket // >
    case openSquareBracket // [
    case closeSquareBracket // ]
    case openParenthesis // (
    case closeParenthesis // )
    
    // Quotes
    case simpleQuote // '
    case doubleQuote // "
    case startMultiLineComment // /'
    case endMultiLineComment // '/
    
    // Arrows
    case hyphen // -
    case x // x
    case o // o
    case pipe // |
    case star // *
    case fullStop // .
    
    // Keywords
    case startUML // @startuml
    case endUML // @enduml
    case participant // participant
    case actor // actor
    case boundary // boundary
    case control // control
    case entity // entity
    case database // database
    case `as` // as
    case `class` // class
    case title // title
    case left // left
    case right // right
    case up // up
    case down // down
    
    // Identifiers
    case identifier(String)
}


extension Token: Equatable {
    
}

extension Token: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case .whitespace: return " "
        case .newline: return "\n"
        case .openCurlyBracket: return "{"
        case .closeCurlyBracket: return "}"
        case .openPointyBracket: return "<"
        case .closePointyBracket: return ">"
        case .openSquareBracket: return "["
        case .closeSquareBracket: return "]"
        case .openParenthesis: return "("
        case .closeParenthesis: return ")"
        case .simpleQuote: return "'"
        case .doubleQuote: return "\""
        case .startMultiLineComment: return "/'"
        case .endMultiLineComment: return "'/"
        case .hyphen: return "-"
        case .star: return "*"
        case .x: return "x"
        case .o: return "o"
        case .pipe: return "|"
        case .fullStop: return "."
        case .startUML: return "@startuml"
        case .endUML: return "@enduml"
        case .participant: return "participant"
        case .actor: return "actor"
        case .boundary: return "boundary"
        case .control: return "control"
        case .entity: return "entity"
        case .database: return "database"
        case .as: return "as"
        case .class: return "class"
        case .title: return "title"
        case .left: return "left"
        case .right: return "right"
        case .up: return "up"
        case .down: return "down"
        case .identifier(let identifier): return identifier
        }
    }
}

extension Token {
    
    var recogniser: TokenRecogniser {
        
        switch self {
        
        case .whitespace:
            return CharacterSetRecogniser(includeSet: .whitespaces, patternConclusionSet: CharacterSet.whitespaces.inverted, whenMatched: { _ in .whitespace })
            
        case .newline:
            return CharacterSetRecogniser(includeSet: .newlines, patternConclusionSet: .all, whenMatched: { _ in .newline })
            
        case .identifier(_):
            return CharacterSetRecogniser(includeSet: .plantUMLIdentifierAllowed,
                                          patternConclusionSet: CharacterSet.plantUMLIdentifierAllowed.inverted) { .identifier($0) }
            
            // .all conclusion
        case .startMultiLineComment,
             .endMultiLineComment,
             .openCurlyBracket,
             .closeCurlyBracket,
             .openPointyBracket,
             .closePointyBracket,
             .openSquareBracket,
             .closeSquareBracket,
             .openParenthesis,
             .closeParenthesis,
             .simpleQuote,
             .doubleQuote,
             .hyphen,
             .x,
             .o,
             .pipe,
             .star,
             .fullStop,
             .left,
             .right,
             .up,
             .down:
            
            return StaticStringRecogniser(stringToMatch: self.description, patternConclusionSet: .all, recognising: self)
            
            // default conclusion
        case .startUML,
             .endUML,
             .participant,
             .actor,
             .boundary,
             .control,
             .entity,
             .database,
             .as,
             .class,
             .title:
            
            return StaticStringRecogniser(stringToMatch: self.description, recognising: self)
        }
    }
    
    static var allRecognisers: [TokenRecogniser] {
        
        return [Token.whitespace.recogniser,
                Token.newline.recogniser,
                Token.openCurlyBracket.recogniser,
                Token.closeCurlyBracket.recogniser,
                Token.openPointyBracket.recogniser,
                Token.closePointyBracket.recogniser,
                Token.openSquareBracket.recogniser,
                Token.closeSquareBracket.recogniser,
                Token.openParenthesis.recogniser,
                Token.closeParenthesis.recogniser,
                Token.simpleQuote.recogniser,
                Token.doubleQuote.recogniser,
                Token.startMultiLineComment.recogniser,
                Token.endMultiLineComment.recogniser,
                Token.hyphen.recogniser,
                Token.x.recogniser,
                Token.o.recogniser,
                Token.pipe.recogniser,
                Token.star.recogniser,
                Token.fullStop.recogniser,
                Token.startUML.recogniser,
                Token.endUML.recogniser,
                Token.participant.recogniser,
                Token.actor.recogniser,
                Token.boundary.recogniser,
                Token.control.recogniser,
                Token.entity.recogniser,
                Token.database.recogniser,
                Token.as.recogniser,
                Token.class.recogniser,
                Token.title.recogniser,
                Token.left.recogniser,
                Token.right.recogniser,
                Token.up.recogniser,
                Token.down.recogniser,
                Token.identifier("anything").recogniser]
    }
}