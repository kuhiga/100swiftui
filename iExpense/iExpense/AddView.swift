//
//  AddView.swift
//  iExpense
//
//  Created by Kurt Higa on 2/17/24.
//

import Foundation
import SwiftUI

struct AddView: View {
    var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save"){
                    saveExpense(name: name, type: type, amount: amount)
                }
            }
        }
    }
    func saveExpense(name: String, type: String, amount: Double){
        let newExpense = ExpenseItem(name: name, type: type, amount: amount)
        if(newExpense.name != "" && newExpense.type != "" && newExpense.amount > 0.00){
            expenses.items.append(newExpense)
            dismiss()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
