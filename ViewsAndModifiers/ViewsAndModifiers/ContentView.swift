//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Kurt Higa on 1/29/24.
//

import SwiftUI

//Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.blue)
            .font(.largeTitle)
    }
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    func prominentTitleStyle() -> some View{
        modifier(ProminentTitle())
    }
}

struct WaterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View{
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func waterMarked(with text: String) -> some View{
        modifier(WaterMark(text: text))
    }
}
struct ContentView: View {
    var body: some View {
        VStack{
            Spacer()
            Spacer()
            Text("Hello world!")
                .prominentTitleStyle()
            Spacer()
            ZStack{
                Color.red
                    .frame(width: 400, height: 300)
                Color.blue
                    .frame(width: 300, height: 200)
                    .waterMarked(with: "Hacking with Swift")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
