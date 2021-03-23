//
//  GestureAnimationOne.swift
//  Animations
//
//  Created by Lékan Mabayoje on 3/23/21.
//

import SwiftUI

struct GestureAnimationOne: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 13.0))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { newPosition in self.dragAmount = newPosition.translation}
                    .onEnded { _ in
                        withAnimation(.interpolatingSpring(stiffness: 50, damping: 10)) {
                            self.dragAmount = .zero
                        }
                    }
            )

    }
}

struct GestureAnimationOne_Previews: PreviewProvider {
    static var previews: some View {
        GestureAnimationOne()
    }
}
