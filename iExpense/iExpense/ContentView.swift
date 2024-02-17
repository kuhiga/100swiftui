//
//  ContentView.swift
//  iExpense
//
//  Created by Kurt Higa on 2/17/24.
//
import Observation
import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}
struct ContentView: View {
    @State private var user = User(firstName: "Kurt", lastName: "Higa  ")
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("Save user"){
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user){
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }  
    }
    func removeRows(at offsets: IndexSet ){
        numbers.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
