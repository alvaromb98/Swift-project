//
//  QuizPlayView.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 10/2/21.
//

import SwiftUI

struct QuizPlayView: View {
    var quizItem: QuizItem
    
    @EnvironmentObject var scoresModel: ScoresModel
    
    @State var answer: String = ""
    
    @State var showAlert = false
    
    var body: some View {        
        VStack {
            HStack{
                Text(quizItem.question)
                    .font(.largeTitle)

                Button(action: {
                    self.quizzesModel.toggleFavourite(quizItem)
                }) {
                
                Image(quizItem.favourite ? "star yellow": "star grey")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                }
            }
            
            TextField("Respuesta",
                      text: $answer,
                      onCommit: {
                showAlert = true
                scoresModel.check(respuesta: answer, quiz: quizItem)
            }
            )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Resultado"),
                          message:
                            Text(self.quizItem.answer.isloweredTrimmedEqual(answer) ? "ok" : "mal"),
                          dismissButton: .default(Text("Ok"))
                    )
                }
            
            Button(action: {
                self.showAlert = true
                scoresModel.check(respuesta: answer, quiz: quizItem)
            }, label: {
                Label("Comprobar", systemImage: "questionmark.circle.fill")
            })
            
            attachment
            author
            
            Text("Score: \(scoresModel.acertadas.count)")
            
        }
    }
    
    private var author: some View {
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return HStack(alignment: .bottom, spacing: 5) {
            Text(quizItem.author?.username ?? "anonimo")
                .font(.callout)
                .foregroundColor(.green)
            NetworkImageView(viewModel: univm)
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 3))
                .contextMenu{
                    Button("Limpiar Respuesta"){
                        answer = ""
                    }
                    Button("Respuesta Correcta"){
                        answer = quizItem.answer
                    }
                }
        }
    }
    
    @State var angle = 0.0
    @State var scale = 1.0

    private var attachment: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        

        return  GeometryReader { g in
            NetworkImageView(viewModel: anivm)
                .scaledToFill()
                .frame(width: g.size.width,
                       height: g.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 4))
                //.padding(30)
                .saturation(self.showAlert ? 0.1 : 1)
                .animation(.easeInOut, value: self.showAlert)
                .rotationEffect(Angle(degrees: angle))
                .scaleEffect(scale)
            
                .onTapGesture(count:2) { 
                    answer = quizItem.answer
                    withAnimation (.spring(response: 1, dampingFraction: 0.3 , blendDuration: 1)) {                   
                    angle += 360                    
                }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation (.spring(response: 1, dampingFraction: 0.3 , blendDuration: 1)) {
                    scale = 1.3 - scale
                    }
                }
            }
     }
        .padding()
    }
}

//struct QuizPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizPlayView()
//    }
//}
