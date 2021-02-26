//
//  ContentView.swift
//  WordScramble
//
//  Created by Lékan Mabayoje on 2/25/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0..<55) { number in
            Text("\(number)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
