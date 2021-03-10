//
//  ContentView.swift
//  WordScramble
//
//  Created by Lékan Mabayoje on 2/25/21.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    
    
    // alert properties
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    
    func addNewWord() {
        // lowercase and trim the charcters entered
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit method if TextField is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Be more original!", message: "This word has already been used!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Hold on there!", message: "You cannot just pull that off and pretend no one is watching!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Really...", message: "\(answer) is not a real word!")
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
    
    // check if the word had not been used
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // check if it's possible to spell a newWord from the rootWord
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    // check if the word is a real word
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    // setting up error alert
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
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
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
