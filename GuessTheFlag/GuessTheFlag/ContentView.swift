//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lékan Mabayoje on 2/6/21.
//

import SwiftUI

// Create view to display a flag
struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
            .shadow(color: Color.blue.opacity(0.6), radius: 4)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var tappedFlag: Int?
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
  
    @State private var spinAmount: Double = 0.0
    @State private var fadeAmount: Double = 1.0
    @State private var scaleAmount: CGFloat = 1.0
    
    var body: some View {
        // Gradient background
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
                
                // View to display all flags as a button
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation(.interpolatingSpring(stiffness: 100, damping: 50)) {
                                self.flagTapped(number)
                            }
                        }) {
                            FlagImage(image: self.countries[number])
                                .rotation3DEffect(
                                    .degrees(number == correctAnswer ? spinAmount : 0.0),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                                .opacity(number == correctAnswer ? 1.0 : fadeAmount)
                                .scaleEffect(number == tappedFlag ? scaleAmount : 1.0)
                        }
                    }
                
                // View to display game score
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
    
    // Runs some conditions everytime a flag is tapped
    func flagTapped(_ number: Int) {
        if let flagIndex = countries.firstIndex(of: countries[number]) {
            tappedFlag = flagIndex
            
            // Check if the flag tappped is the correct answer
            // of if the flag tapped is matches it's index value
            if number == correctAnswer {
                spinAmount += 360
                fadeAmount = 0.1
                scoreTitle = "Correct!"
                score += 1
                alertMessage = "You score 1 point!"
            } else if number == tappedFlag {
                scaleAmount = 0.2
                scoreTitle = "Wrong!"
                alertMessage = "Sorry that's the flag of \(countries[number])."
            }
        }
        
        showingScore = true
        print("flag tapped is: \(countries[number]) (\(tappedFlag!)), correct flag is: \(countries[correctAnswer])")
    }
    
    // Runs to trigger the next question
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in:  0...2)
        fadeAmount = 1.0
        scaleAmount = 1.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
