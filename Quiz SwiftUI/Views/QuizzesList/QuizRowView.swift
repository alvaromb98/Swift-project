//
//  QuizRowView.swift
//  Quiz SwiftUI
//
//  Created by user205881 on 9/27/21.
//

import SwiftUI

struct QuizRowView: View {
    
    var quizItem: QuizItem
    
    var body: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return
        HStack{
            NetworkImageView(viewModel: anivm)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 4))
            VStack {
                Text(quizItem.question)
                    .font(.headline)
                Image(quizItem.favourite ? "star yellow": "star grey")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .scaledToFit()
                HStack(alignment: .bottom, spacing: 5) {
                    Text(quizItem.author?.username ?? "anonimo")
                        .font(.callout)
                        .foregroundColor(.green)
                    NetworkImageView(viewModel: univm)
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 3))
                }
            }
        }
    }
}

//struct QuizRowView_Previews: PreviewProvider {
//   static var previews: some View {
//      QuizRowView()
//}
//}QuizRowView
