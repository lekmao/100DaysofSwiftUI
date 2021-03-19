//
//  ContentView.swift
//  Animations
//
//  Created by Lékan Mabayoje on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwifUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(dragAmount)
                    .animation(
                        Animation.default
                            .delay(Double(num) / 20)
                    )
            }
            .gesture(
                DragGesture()
                    .onChanged { newPosition in self.dragAmount = newPosition.translation}
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
//    .frame(width: 300, height: 200)
//    .clipShape(RoundedRectangle(cornerRadius: 13.0))
//    .offset(dragAmount)
//    .gesture(
//        DragGesture()
//            .onChanged { newPosition in self.dragAmount = newPosition.translation}
//            .onEnded { _ in
//                withAnimation(.interpolatingSpring(stiffness: 50, damping: 10)) {
//                    self.dragAmount = .zero
//                }
//            }
//    )
