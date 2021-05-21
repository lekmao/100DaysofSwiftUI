//
//  ShowHideView.swift
//  iExpense
//
//  Created by Lékan Mabayoje on 5/20/21.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
//    var name: String
    
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ShowHideView: View {
    @State private var showingSheet: Bool = false
    
    var body: some View {
        Button("Show sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct ShowHideView_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideView()
    }
}
