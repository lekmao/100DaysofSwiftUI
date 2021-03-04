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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
