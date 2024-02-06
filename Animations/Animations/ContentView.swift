//
//  ContentView.swift
//  Animations
//
//  Created by Kurt Higa on 2/4/24.
//
  
import SwiftUI
 
struct CornerRotateModifier: ViewModifier{
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(
            amount: -90, anchor: .topLeading),
            identity:
                CornerRotateModifier(amount: 0 , anchor: .topLeading)
        )
    }
}
struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View{
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if(isShowingRed){
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
    }
////    @State private var enabled = false
//    @State private var isShowingRed = false
//    var body: some View{
//        VStack{
//            Button("Tap me"){
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//                //            enabled.toggle()
//            }
//            if isShowingRed{
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
////                    .transition(.scale)
//            }
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .blue : .red)
//        .foregroundStyle(.white)
//        .animation(.default, value: enabled)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.spring(response: 1, dampingFraction: 0.9), value: enabled)
//    }
//    @State private var animationAmount = 1.0
//    @State private var animationAmount = 0.0
//
//    var body: some View{
//        Button("Tap me"){
//            withAnimation(){
//                animationAmount += 360
//            }
//        }
//        .padding(40)
//        .background(.red)
//        .foregroundStyle(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(
//            .degrees(animationAmount),
//            axis: (x: 0.0, y: 1.0, z: 0.0))
//    }
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
