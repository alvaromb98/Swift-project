//
//  ContentView.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 9/27/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel

    @EnvironmentObject var scoreModel: ScoresModel
    
    @State var verTodo: Bool = true

    var body: some View {
        NavigationView{
            List {
                Toggle("Ver Todo", isOn: $verTodo.animation())
                ForEach(quizzesModel.quizzes){ qi in
                    if verTodo || !scoreModel.acertada(qi){
                        NavigationLink(destination: QuizPlayView(quizItem: qi)) {
                            QuizRowView(quizItem: qi)
                        }                        
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Quiz SwiftUI"))
            .navigationBarItems(leading: Text("Record: \(scoreModel.record.count)").font(.title3),
                                trailing: Button(action: {
                                    quizzesModel.download()
                                    scoreModel.limpiar()
            }) {
                Label("Reload", systemImage: "arrow.triangle.2.circlepath")
            }
            )
            .onAppear {
                quizzesModel.download()
            }
            
            Text("Split View Controller - Detail")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizzesListView()
//    }
//}
