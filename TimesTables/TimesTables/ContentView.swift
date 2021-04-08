//
//  ContentView.swift
//  TimesTables
//
//  Created by Lékan Mabayoje on 4/6/21.
//

// Let user select what multiplication tables to practice
// Let user select difficulty level
// Let user select how many questions to answer
// Strat game

import SwiftUI

// Create game settings view
struct SettingsView: View {
    let multiplierRange: ClosedRange<Int>
    let multiplierSelection: Binding<Int>
    
    let difficultyLevels: [String]
    let difficultySelection: Binding<Int>
    
    let numberOfQuestions: [Int]
    let numberofQuestionsSelection: Binding<Int>
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Select multiplications table")) {
                    Picker("Multiplications", selection: multiplierSelection) {
                        ForEach(multiplierRange, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                }
                
                Section(header: Text("Select difficilty level")) {
                    Picker("Difficulty", selection: difficultySelection) {
                        ForEach(0..<difficultyLevels.count) { level in
                            Text("\(self.difficultyLevels[level])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select number of questions to answer")) {
                    Picker("Questions", selection: numberofQuestionsSelection) {
                        ForEach(0..<numberOfQuestions.count) { number in
                            Text("\(self.numberOfQuestions[number])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .frame(height: 300)
            Button(action: action) {
                Text("Start game")
                    .font(.body)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(6)
                    .padding()
            }
            
            Spacer()
            
        }
    }
}

// Create game play view
struct GamePlay: View {
    @State private var userAnswer: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("What is the product of ")
                HStack {
                    Text("\(5)")
                    Text("x")
                    Text("\(10)")
                }
            }
            Text("Answer here")
            
            TextField("Enter answer here", text: $userAnswer)
                .padding()
            Spacer()
        }
    }
}


struct ContentView: View {
    
    let multiplierRange: ClosedRange<Int> = 1...12
    @State private var multiplierSelection: Int = 1
    
    let difficultyLevels: [String] = ["Easy", "Medium", "Hard"]
    @State private var difficultySelection: Int = 0
    
    let numberOfQuestions: [Int] = [5, 10, 20]
    @State private var numberofQuestionsSelection: Int = 0
    
    let multiplicandRange: [ClosedRange<Int>] = [1...10, 11...20, 21...50]
    var multiplicand: Int {
        randomMultiplicand()
    }
    @State private var gameStettings: Bool = false
    @State private var startGame: Bool = true
    
    var body: some View {
        NavigationView {
            Group {
                if gameStettings == true {
                    SettingsView(
                        multiplierRange: multiplierRange,
                        multiplierSelection: $multiplierSelection,
                        difficultyLevels: difficultyLevels,
                        difficultySelection: $difficultySelection,
                        numberOfQuestions: numberOfQuestions,
                        numberofQuestionsSelection: $numberofQuestionsSelection,
                        action: {
                            print("Hello")
                            gameStettings = false
                            startGame = true
                            print(startGame)
                            print("Difficulty is: \(difficultyLevels[difficultySelection])")
                        }
                    )
                } else if startGame == true {
                    //                    VStack {
                    //                        Text("Game has started!")
                    //                        Text("Multiplier is: \(multiplierSelection)")
                    //                        Text("Difficulty is: \(difficultyLevels[difficultySelection])")
                    //                        Text("Questions are: \(numberOfQuestions[numberofQuestionsSelection])")
                    //                        Text("Multiplicand is: \(multiplicand)")
                    //                    }
                    GamePlay()
                }
            }
            .navigationTitle("Times Tables")
        }
    }
    
    // Generate a random number from an array of ranges based on difficulty level
    func randomMultiplicand() -> Int {
        Int.random(in: multiplicandRange[difficultySelection])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
