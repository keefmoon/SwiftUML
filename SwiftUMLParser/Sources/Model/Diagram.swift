//
//  Diagram.swift
//  SwiftUMLParser
//
//  Created by Keith Moon on 09/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

protocol DiagramLayoutable { }

protocol Diagram {
    
    var elements: [DiagramLayoutable] { get }
}

struct SequenceDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct UsecaseDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct ClassDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct ActivityDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct ComponentDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct StateDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
struct ObjectDiagram: Diagram {
    var elements: [DiagramLayoutable]
}
