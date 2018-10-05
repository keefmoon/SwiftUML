//
//  main.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

import SwiftUMLParser

let tokeniser = Tokeniser()
//let token = tokeniser.tokenise("wlass")

//print("class: \(tokeniser.tokenise("class")): YES")
//print("wclass: \(tokeniser.tokenise("wclass")): YES")
//print("classw: \(tokeniser.tokenise("classw")): YES")
//print("wclassw: \(tokeniser.tokenise("wclassw")): YES")
//print("wlass: \(tokeniser.tokenise("wlass")): NO")
print("class class: \(tokeniser.tokenise("class class"))")
