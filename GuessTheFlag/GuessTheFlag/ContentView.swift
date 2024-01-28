//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kurt Higa on 1/27/24.
//

import SwiftUI

struct ContentView: View   {
    @State private var showingAlert = false
    var body: some View {
//        ZStack{
//            LinearGradient(stops: [
//                Gradient.Stop(color: .yellow, location: 0.23),
//                Gradient.Stop(color: .blue, location: 0.66),
//                Gradient.Stop(color: .red, location: 1)
//            ], startPoint: .top, endPoint: .bottom)
//            RadialGradient(colors: [. green, .blue], center: .center, startRadius: 20, endRadius: 200)
//            AngularGradient(colors: [.red, .yellow, .green, .purple, .red], center: .center)
//            Text("Your content")
//                    .foregroundStyle(.secondary)
//                    .padding(50)
//                    .background(.ultraThinMaterial)
//        }
//        .ignoresSafeArea()
        
        Button {
            print("Edit button was tapped")
            showingAlert = true
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
                .foregroundStyle(.white)
                .background(.cyan)
        }
        .alert("Important message", isPresented: $showingAlert){
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Do you remember when you were younger and the days in the summer lasted forever?")
        }
//        Image(systemName: "pencil.circle")
//            .foregroundStyle((.red))
//            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
