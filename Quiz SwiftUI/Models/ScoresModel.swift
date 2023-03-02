//
//  ScoresModel.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 10/3/21.
//

import Foundation

class ScoresModel: ObservableObject {
    
    @Published private(set) var acertadas: Set<Int> = []

    @Published private(set) var record: Set<Int> = []

    init() {
        if let record = UserDefaults.standard.object(forKey: "record") as? [Int]{
            self.record = Set(record)
        }
    }
    
    func check(respuesta: String, quiz: QuizItem) {
        if respuesta =+-= quiz.answer {
            acertadas.insert(quiz.id)
            record.insert(quiz.id)

            UserDefaults.standard
               .set(Array<Int>(record), forKey: "record")
            }
      }
    func acertada(_ quizItem: QuizItem) -> Bool {
        return acertadas.contains(quizItem.id)
    }

    func limpiar() {
        acertadas = []
    }
}
