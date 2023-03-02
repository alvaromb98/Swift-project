//
//  String.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 10/3/21.
//

import Foundation

infix operator =+-= : ComparisonPrecedence

extension String {
    //Devuelve el string lowered y trimmed
    func loweredTrimmed() -> String {
        self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Compara igualdad despue de lowered y trimmed
    func isloweredTrimmedEqual(_ str: String) -> Bool {
        self.loweredTrimmed() == str.loweredTrimmed()
    }
    
    // Compara si dos string son mas o menos iguales, su igualdad despues de lowered y trimmed
    static func =+-= (s1: String, s2: String) -> Bool {
        s1.isloweredTrimmedEqual(s2)
    }
}
