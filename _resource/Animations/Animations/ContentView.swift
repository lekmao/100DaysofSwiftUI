//
//  ContentView.swift
//  Animations
//
//  Created by Lékan Mabayoje on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: Double = 0.0
    
    var body: some View {
        Button("Tap Here") {
            withAnimation(.interpolatingSpring(stiffness: 10, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        . foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1.0, y: 0.0, z: 0.0)
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
