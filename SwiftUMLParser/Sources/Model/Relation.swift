//
//  Relation.swift
//  SwiftUMLParser
//
//  Created by Keith Moon on 09/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

struct Relation: DiagramLayoutable {
    
    enum ArrowHead {
        case inheritance
        case `extension`
        case composition
        case aggregation
    }
    
    struct End {
        let head: ArrowHead?
        let label: String?
        unowned var node: Node
    }
    
    enum LineStyle {
        case normal
        case dotted
    }
    
    let label: String?
    let leading: End
    let trailing: End
    let style: LineStyle
}
