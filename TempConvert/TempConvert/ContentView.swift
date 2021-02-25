//
//  ContentView.swift
//  TempConvert
//
//  Created by Lékan Mabayoje on 2/3/21.
//

// Create selector for input unit
// Create input field
// Create output fields

import SwiftUI

struct ContentView: View {
    @State private var currentSelection: Int = 0
    @State private var inputValue: String = ""

    let temperatureUnits: [String] = ["celcius", "fahrenheit", "kelvin"]
    
    var celciusValue: Double {
        switch temperatureUnits[currentSelection] {
            case "fahrenheit":
                let value = Double(inputValue) ?? 0
                return Double((value - 32) * 5/9)
                
            case "kelvin":
                let value = Double(inputValue) ?? 0
                return Double(value - 273.15)
                
            default:
                return Double(inputValue) ?? 0
        }
            

    }
    
    var celciusToFahrenheit: Double {
        let fahrenheitValue = Double((celciusValue * 9/5) + 32)
        
        return fahrenheitValue
    }
    
    var celciusToKelvin: Double {
        let kelvinValue = Double(celciusValue + 273.15)
        
        return kelvinValue
    }
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select unit to convert")) {
                    Picker("Tempatrure Units", selection: $currentSelection) {
                        ForEach(0 ..< temperatureUnits.count) { selectedUnit in
                            Text("\(self.temperatureUnits[selectedUnit])")
                        }
                    }
                                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter value to convert")) {
                    TextField("Enter value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                
                ForEach(0 ..< temperatureUnits.count) { unit in
                    if temperatureUnits[currentSelection] != temperatureUnits[unit] {
                        Section(header: Text("\(temperatureUnits[unit])")) {
                            switch temperatureUnits[unit] {
                            case "celcius":
                                Text(inputValue.isEmpty ? "0" : "\(celciusValue, specifier: "%.f")\u{00B0}C")
                                
                            case "fahrenheit":
                                Text(inputValue.isEmpty ? "0" : "\(celciusToFahrenheit, specifier: "%.f")\u{00B0}F")
                                
                            default:
                                Text(inputValue.isEmpty ? "0" : "\(celciusToKelvin, specifier: "%.f")K")
                                
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle("TempConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
