//
//  SettingsView.swift
//  iExpense
//
//  Created by Kurt Higa on 2/17/24.
//

import Foundation
import SwiftUI

struct SettingsView: View{
    var settings: Settings
    @Environment(\.dismiss) var dismiss
    @State private var selectedCurrency: String
    let currencies = ["USD", "JPY"]
    // Custom initializer
    init(settings: Settings) {
        self.settings = settings
        // Initialize the @State property with the value from settings
        _selectedCurrency = State(initialValue: settings.preferredCurrency)
    }
    var body: some View{
        NavigationStack{
            Form{
                Section(){
                    Picker("Currency", selection: $selectedCurrency){
                        ForEach(currencies, id: \.self){
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                Button("Save"){
                    settings.preferredCurrency = selectedCurrency
                    dismiss()
                }
            }

        }

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: Settings())
    }
}
