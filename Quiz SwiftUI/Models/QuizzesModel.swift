 //
//  QuizzesModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 17/09/2021.
//

import Foundation

class QuizzesModel: ObservableObject {
    
    // Los datos
    @Published private(set) var quizzes = [QuizItem]()

    let TOKEN = "db08188a25ce1fc499ba"
    let URL_BASE = "https://core.dit.upm.es/api"
    
    func load() {
                
        guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
//            if let str = String(data: data, encoding: String.Encoding.utf8) {
//                print("Quizzes ==>", str)
//            }
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            
            self.quizzes = quizzes

            print("Quizzes cargados")
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }

    func download() {

        let urlStr = "\(URL_BASE)/quizzes/random10wa?token=\(TOKEN)"

        guard let url = URL(string: urlStr) else {
            print("Error 1: URL no funciona")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in 

            if error == nil, 
                (response as! HTTPURLResponse).statusCode == 200,
                let data = data {

                    do {  

                        let quizzes = try JSONDecoder().decode([QuizItem].self, from: data)

                        DispatchQueue.main.async {
                        self.quizzes = quizzes
                        }
                    } catch {
                            print("Error 3: json mal \(error)")
                    }

            } else {
                print("Error 2: petición mal")
            }            
        }
        .resume()
    }

    func toggleFavourite(_ quizItem: QuizItem) {
        let surl = "\(URL_BASE)//users/tokenOwner/favourites/\(quizItem.id)?token=\(TOKEN)"

        guard let url = URL(string: surl) else {
            print("Fallo creando URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With") // Comentar esta línea si no funciona

        let t = session.uploadTask(with: request, from: Data()) {(data, res, error) in

            if error != nil {
                print("Error 20")
                return
            }

            if (res as! HTTPURLResponse).statusCode != 200 {
                print("Error 30")
                return
            }

            DispatchQueue.main.async {
                self.quizzes.favourite.Toggle()
            }

        }
        .resume()
    }

}
