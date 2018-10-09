//
//  CommonModels.swift
//  SwiftUMLParser
//
//  Created by Keith Moon on 09/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

enum Visibility {
    case `private`
    case protected
    case packagePrivate
    case `public`
}

protocol HasVisibility {
    var visibility: Visibility? { get }
}

enum Modifier {
    case `static`
    case abstract
}

protocol HasModifier {
    var modifier: Modifier? { get }
}

protocol ClassInternal { }

struct Field: HasVisibility, ClassInternal {
    let name: String
    let type: String
    let visibility: Visibility?
}

struct Method: HasVisibility, ClassInternal {
    let signature: String
    let visibility: Visibility?
}

struct CommentLine: ClassInternal {
    let text: String
}

struct Divider: ClassInternal {
    
    enum Style {
        case single
        case double
        case dotted
    }
    
    let label: String?
    let style: Style
}
