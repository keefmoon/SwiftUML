//
//  TokenRecogniser.swift
//  SwiftUML
//
//  Created by Keith Moon on 04/10/2018.
//  Copyright © 2018 Keith Moon. All rights reserved.
//

protocol TokenRecogniser {
    func attemptRecognition(of scalar: UnicodeScalar, withLookAheadScalar lookAheadScalar: UnicodeScalar?) -> Token?
    func clear()
}
