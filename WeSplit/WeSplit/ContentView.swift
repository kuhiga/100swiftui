//
//  ContentView.swift
//  WeSplit
//
//  Created by Kurt Higa on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Bob", "Jordan"]
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationStack{
            Form{
                Picker("Select your students", selection: $selectedStudent){
                    ForEach(students, id: \.self){
                        Text($0)
                    }
                }
            }
            .navigationTitle("Select a students")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
