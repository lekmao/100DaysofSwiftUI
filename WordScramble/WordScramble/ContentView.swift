//
//  ContentView.swift
//  WordScramble
//
//  Created by Lékan Mabayoje on 2/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
    func addNewWord() {
        // lowercase and trim the charcters entered
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit method if TextField is empty
        guard answer.count > 0 else {
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        // find URL for start.txt in the app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split string into an array of strings using line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // pick one random word, or use "silkworm" as a default word
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // if all goes well, this is the method exit
                return
            }
        }
        
        // if the above statement does not exit, this runs
        fatalError("Could not load start.txt from bundle.")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) { usedWord in
                    Image(systemName: "\(usedWord.count).circle")
                    Text("\(usedWord)")
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
