//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Lékan Mabayoje on 2/9/21.
//

import SwiftUI

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(16)
            .background(Color.black)
            .cornerRadius(8)
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(CustomButton())
    }
}

struct CustomWatermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.purple)
                .cornerRadius(4)
        }
    }
}

extension View {
    func customWatermarkStyle(customText: String) -> some View {
        self.modifier(CustomWatermark(text: customText))
    }
}


struct ShowTime: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func customShowTimeStyle() -> some View {
        self.modifier(ShowTime())
    }
}

struct Celebrate: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        VStack {
            content
            Text(text)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

extension View {
    func celebrateStyle(text: String) -> some View {
        self.modifier(Celebrate(text: text))
    }
}

struct ContentView: View {
  
    var body: some View {
        ZStack {
          
            Color.yellow
                .ignoresSafeArea()
                .customWatermarkStyle(customText: "Stamp Here!")
            
            HStack {
                Text("Represent!!!")
                    .customButtonStyle()
                    .celebrateStyle(text: "Celebrate")
                Text("Show Time")
                    .customShowTimeStyle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
