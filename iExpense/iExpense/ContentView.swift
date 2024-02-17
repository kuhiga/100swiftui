//
//  ContentView.swift
//  iExpense
//
//  Created by Kurt Higa on 2/17/24.
//
import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
@Observable
class Expenses {
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}
@Observable
class Settings{
    init(){
        if let savedPreferredCurrency = UserDefaults.standard.string(forKey: "preferredCurrency"){
            preferredCurrency = savedPreferredCurrency
            return
        }
        preferredCurrency = "USD"
    }
    var preferredCurrency = String(){
        didSet{
            UserDefaults.standard.set(preferredCurrency, forKey: "preferredCurrency")
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var settings = Settings()
    @State private var showingAddExpense = false
    @State private var showingSettings = false
    @State private var showDeleteAlert = false
    private var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }

    private var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Personal expenses")){
                    ForEach(personalItems){  item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Text(item.amount, format: .currency(code: settings.preferredCurrency))
                                .foregroundColor(item.amount > 100 ? .red : .primary)

                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section(header: Text("Business expenses")){
                    ForEach(businessItems){  item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Text(item.amount, format: .currency(code: settings.preferredCurrency))
                                .foregroundColor(item.amount > 100 ? .red : .primary)

                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .alert(isPresented: $showDeleteAlert){
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete all items?"),
                    primaryButton: .destructive(Text("Delete All")) {
                        expenses.items.removeAll()
                    },
                    secondaryButton: .cancel()
                )
            }
            .toolbar{
                Button("Setting", systemImage: "gear"){
                    showingSettings = true
                }
                Button("Delete All", systemImage: "trash"){
                    if(!expenses.items.isEmpty){
                        showDeleteAlert = true
                    }
                }
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses, currency: settings.preferredCurrency)
        }
        .sheet(isPresented: $showingSettings, content: {
            SettingsView(settings: settings)
        })
        
    }
    func removeItems(at offsets: IndexSet ){
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
