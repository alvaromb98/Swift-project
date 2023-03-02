//
//  Quiz_SwiftUIApp.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 9/27/21.
//
import SwiftUI

@main
struct Quiz_SwiftUIApp: App {
    
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()

    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
        }
    }
}
