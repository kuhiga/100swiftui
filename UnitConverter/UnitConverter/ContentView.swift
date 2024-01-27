//
//  ContentView.swift
//  UnitConverter
//
//  Created by Kurt Higa on 1/27/24.
//
//You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
//
//Which units you choose are down to you, but you could choose one of these:
//
//Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
//Length conversion: users choose meters, kilometers, feet, yards, or miles.
//Time conversion: users choose seconds, minutes, hours, or days.
//Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
//If you were going for length conversion you might have:
//
//A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
//A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
//A text field where users enter a number.
//A text view showing the result of the conversion.
//So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
//
//You know almost everything you need to build this. In fact, if you go for a simple solution – and I hope you do – the only actually new thing you’ll find is that you need to use a different format option for your text field, because .currency and .percent don’t make sense here. You should choose .number instead, which is suitable for standard numerical input.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 1.0
    @FocusState private var amountIsFocused: Bool
    @State private var unitOption = "kg"
    @State private var convertToUnit = "lb"
    let multiplier = 2.205
    var description: String {
        return "Convert \(unitOption) to \(convertToUnit)"
    }
    var result: Double {
        if(unitOption == convertToUnit){
            return value
        }
        return unitOption == "kg" ? value * multiplier : value / multiplier
    }
    let unitOptions = ["kg", "lb"]
    var body: some View {
        NavigationStack{
            Form {
                Section(description){
                    TextField("Value", value: $value, format: .number )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Unit", selection: $unitOption){
                        ForEach(unitOptions, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section{
                    Text(result, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Unit", selection: $convertToUnit){
                        ForEach(unitOptions, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Mass Converter")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                          amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
