//
//  UserDefaultSettings.swift
//  iExpense
//
//  Created by Lékan Mabayoje on 5/20/21.
//

import SwiftUI

struct UserDefaultSettings: View {
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct UserDefaultSettings_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultSettings()
    }
}
