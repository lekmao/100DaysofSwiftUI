//
//  ContentView.swift
//  WeSplit
//
//  Created by Dallas On-hand 3 on 1/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var orderAmount: Double {
        return Double(checkAmount) ?? 0
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tip = tipSelection / 100 * orderAmount
        
        return tip
    }
    
    var checkTotal: Double {
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let amountPerPerson = checkTotal / peopleCount

        return amountPerPerson
    }
    

    var body: some View {
        NavigationView {
            Form {
                // Check Amount
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                // Number of People
                Section(header: Text("Number of People")) {
                    TextField("Enter the number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                // Tip Selection
                Section(header: Text("How much tip do you want to leave?"), footer: Text("Tip is $\(tipValue, specifier: "%.2f")") ) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) { selectedTip in
                            Text("\(self.tipPercentages[selectedTip])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Total Check Amount
                Section(header: Text("Total Check Amount")) {
                    Text("$\(checkTotal, specifier: "%.2f")")
//                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
                
                // Amount Per Person
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
