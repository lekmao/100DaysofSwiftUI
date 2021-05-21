//
//  OnDelete.swift
//  iExpense
//
//  Created by Lékan Mabayoje on 5/20/21.
//

import SwiftUI

struct OnDelete: View {
    @State private var numbers: [Int] = []
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(trailing: EditButton())
        }
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct OnDelete_Previews: PreviewProvider {
    static var previews: some View {
        OnDelete()
    }
}
