//
//  ContentView.swift
//  Animations
//
//  Created by Kurt Higa on 2/4/24.
//
  
import SwiftUI
 
struct ContentView: View {
//    @State private var animationAmount = 1.0
    @State private var animationAmount = 0.0

    var body: some View{
        Button("Tap me"){
            withAnimation(){
                animationAmount += 360
            }
        }
        .padding(40)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0))
    }
//    var body: some View {
//        print(animationAmount)
//        return  VStack{
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//            Spacer()
//            Button("Tap me"){
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
//    }
//    var body: some View {
//        Button("Tap me"){
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundStyle(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeInOut(duration: 1.0)
//                    .repeatForever(autoreverses: false),
//                    value: animationAmount
//                )
//        ).onAppear {
//            animationAmount = 2
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
