//
//  OriginalGame.swift
//  GuessTheFlag
//
//  Created by Lékan Mabayoje on 3/24/21.
//

import SwiftUI

//struct FlagImage: View {
//    var image: String
//    
//    var body: some View {
//        Image(image)
//            .renderingMode(.original)
//            .clipShape(Capsule())
//            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
//            .shadow(color: Color.blue.opacity(0.6), radius: 4)
//    }
//}

struct OriginalGame: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        
                }
                .foregroundColor(.white)
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                }
                
                Text("Score: \(score)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black)
                    .cornerRadius(10)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            alertMessage = "You score 1 point!"
        } else {
            scoreTitle = "Wrong!"
            alertMessage = "Sorry that's the flag of \(countries[number])."
            
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in:  0...2)
    }
}

struct OriginalGame_Previews: PreviewProvider {
    static var previews: some View {
        OriginalGame()
    }
}
