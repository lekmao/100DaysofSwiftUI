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
    @State var multiplierSelection: Int
    
    let difficultyLevels: [String]
    @State var difficultySelection: Int
    
    let numberOfQuestions: [Int]
    @State var numberofQuestionsSelection: Int
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Select multiplications table")) {
                    Picker("Multiplications", selection: $multiplierSelection) {
                        ForEach(multiplierRange, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                }
                
                Section(header: Text("Select difficilty level")) {
                    Picker("Difficulty", selection: $difficultySelection) {
                        ForEach(0..<difficultyLevels.count) { level in
                            Text("\(self.difficultyLevels[level])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select number of questions to answer")) {
                    Picker("Questions", selection: $numberofQuestionsSelection) {
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
            }
//            .padding(0)
            .frame(width: 295, height: 48 )
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(6)
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
    
    var body: some View {
        NavigationView {
            Group {
                SettingsView(
                    multiplierRange: multiplierRange,
                    multiplierSelection: multiplierSelection,
                    difficultyLevels: difficultyLevels,
                    difficultySelection: difficultySelection,
                    numberOfQuestions: numberOfQuestions,
                    numberofQuestionsSelection: numberofQuestionsSelection,
                    action: {}
                )
            }
            .navigationTitle("Times Tables")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
