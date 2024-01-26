//
//  ContentView.swift
//  WeSplit
//
//  Created by Kurt Higa on 1/25/24.
//

import SwiftUI

  struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    var total: Double {
          let tipSelection = Double(tipPercentage)
          let tipValue = checkAmount / 100 * tipSelection
          let grandTotal = checkAmount + tipValue
          return grandTotal
    }
      var totalPerPerson: Double {
          let peopleCount = Double(numberOfPeople + 2)
          let grandTotal = total
          let amountPerPerson = grandTotal / peopleCount;
          return amountPerPerson
      }
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?"){
//                    Picker("Tip", selection: $tipPercentage){
//                        ForEach(tipPercentages, id: \.self){
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
                    Picker("Tip", selection: $tipPercentage){
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount"){
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
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
