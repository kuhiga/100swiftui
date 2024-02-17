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

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showDeleteAlert = false
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses.items){  item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Text(item.amount, format: .currency(code: "USD"))

                    }
                }
                .onDelete(perform: removeItems)
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
            AddView(expenses: expenses)
        }
        
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
