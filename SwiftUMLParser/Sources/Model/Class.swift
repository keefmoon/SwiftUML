//
//  Class.swift
//  SwiftUMLParser
//
//  Created by Keith Moon on 09/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

class Class: Node {
    
    enum Layout {
        case `default`(fields: [Field], methods: [Method])
        case custom([ClassInternal])
    }
    
    let name: String
    let stereotype: String?
    let layout: Layout
    
    fileprivate init(name: String, stereotype: String? = nil, layout: Layout) {
        self.name = name
        self.stereotype = stereotype
        self.layout = layout
    }
}

extension Class {
    
    class Builder {
        
        let name: String
        let stereotype: String?
        private(set) var layout: Class.Layout = .default(fields: [], methods: [])
        
        init(name: String, stereotype: String? = nil) {
            self.name = name
            self.stereotype = stereotype
        }
        
        func add(_ field: Field) {
            
            switch layout {
                
            case .default(fields: var fields, methods: let methods):
                fields.append(field)
                layout = .default(fields: fields, methods: methods)
                
            case .custom(var internals):
                internals.append(field)
                layout = .custom(internals)
            }
        }
        
        func add(_ method: Method) {
            
            switch layout {
                
            case .default(fields: let fields, methods: var methods):
                methods.append(method)
                layout = .default(fields: fields, methods: methods)
                
            case .custom(var internals):
                internals.append(method)
                layout = .custom(internals)
            }
        }
        
        func add(_ classInternal: ClassInternal) {
            
            switch layout {
                
            case .default(fields: let fields, methods: let methods):
                var internals = [ClassInternal]()
                internals.append(contentsOf: fields)
                internals.append(contentsOf: methods)
                layout = .custom(internals)
                
            case .custom(var internals):
                internals.append(classInternal)
                layout = .custom(internals)
            }
        }
        
        func build() throws -> Class {
            
            let builtClass = Class(name: name, stereotype: stereotype, layout: layout)
            return builtClass
        }
    }
}

extension Class: CustomStringConvertible {
    
    var description: String {
        return "class \(name) {\n\n}"
    }
}
