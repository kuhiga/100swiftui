//
//  ContentView.swift
//  Navigation
//
//  Created by Kurt Higa on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List(0..<100){ i in
                NavigationLink("select \(i)", value: i)
            }
            .navigationDestination(for: Int   .self){ selection in
                  Text("You selected \(selection  )")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
