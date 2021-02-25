//
//  ContentView.swift
//  RPSChallenge
//
//  Created by Lékan Mabayoje on 2/13/21.
//

// Three buttons for the players moves
// State what move would win or lose to the apps choice

import SwiftUI

// Create view to display the Game Moves
struct GameMoveView: View {
    var symbol: String
    var name: String
    
    var body: some View {
        VStack {
            Text(symbol)
                .font(.largeTitle)
            Text(name)
                .font(.footnote)
                .foregroundColor(.black)
        }
        .frame(width: 80, height: 80)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.5), radius: 10)
    }
}

// Create view to display the app choice and win condition
struct AppSelectionView: View {
    var prompt: String
    var name: String
    var symbol: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(prompt)
                .font(.headline)
            VStack {
                Text(symbol)
                    .font(.system(size: 72))
                Text(name)
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
        .frame(width: 325)
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
//        .shadow(color: Color.gray.opacity(0.5), radius: 10)
    }
}

// Create a struct for the moves
struct GameMove {
    let id = UUID()
    var name: String
    var symbol: String
}


struct ContentView: View {
    // Anything that would chnage overtime becomes a state
    @State private var score: Int = 0
    @State private var shouldWin: Bool = Bool.random()
    @State private var appSelection: Int = Int.random(in: 0 ..< 3)
    
    
    // Game Move
    var rock: GameMove = GameMove(name: "rock", symbol: "👊🏿")
    var paper: GameMove = GameMove(name: "paper", symbol: "✋🏿")
    var scissors: GameMove = GameMove(name: "scissors", symbol: "✌🏿")
    
    
    // Game Move Collection
    var gameMoveCollection: [GameMove] {
        let gameMoveCollection = [rock, paper, scissors]
        return gameMoveCollection
    }
    
    
    // App Selection
//    var appSelection: GameMove {
//        let appSelection = gameMoveCollection[randomSelection]
//        return appSelection
//    }
    
    // App Prompt
    var appPrompt: String {
        if shouldWin {
            return "What move wins against"
        } else {
            return "What move loses against"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
            VStack(spacing: 40) {
                Text("Score is: \(score)")
                AppSelectionView(prompt: appPrompt, name: gameMoveCollection[appSelection].name, symbol: gameMoveCollection[appSelection].symbol)
                HStack(spacing: 24) {
                    ForEach(gameMoveCollection, id: \.id) { move in
                        Button(action: {
                            self.playMove(move)
                        }) {
                            GameMoveView(symbol: move.symbol , name: move.name.capitalized)
                        }
                    }
                    
                }
            }
        }
    }
    
//    func newAppMove() {
//        appSelection = gameMoveCollection[randomSelection]
//
//    }
 
    func playMove(_ move: GameMove) {
        if shouldWin && (gameMoveCollection[appSelection].name == rock.name && move.name == paper.name || gameMoveCollection[appSelection].name == paper.name && move.name == scissors.name || gameMoveCollection[appSelection].name == scissors.name && move.name == rock.name) {
            
            print("You Won")
            score += 1
        } else if !shouldWin && (gameMoveCollection[appSelection].name == rock.name && move.name != paper.name || gameMoveCollection[appSelection].name == paper.name && move.name != scissors.name || gameMoveCollection[appSelection].name == scissors.name && move.name != rock.name) {
            
            print("You Won")
            score += 1
        } else {
            print("You Lost")
        }
        
        shouldWin = Bool.random()
        appSelection = Int.random(in: 0 ..< 3)
        
    }
    
//    Need to add game count and refactor score UI
//    Add timer to see how many toy could get right in x-amount of minutes
//    Share high score with friends and challenge them to beat it [practice mode vs challenege mode]
//    Sign-In with Apple ID to record high score
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
