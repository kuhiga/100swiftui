//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kurt Higa on 1/27/24.
//

import SwiftUI

struct Round: ViewModifier {
    func body(content:Content) -> some View{
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

extension View{
    func roundStyle() -> some View{
        modifier(Round())
    }
}
struct Conditional3DRotation: ViewModifier {
    var shouldRotate: Bool
    var degrees: Double

    func body(content: Content) -> some View {
        if shouldRotate {
            content.rotation3DEffect(.degrees(degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
        } else {
            content
        }
    }
}

struct FlagImage: View {
    var text: String
    var rotateAmount: Double
    var opacityAmount: Double
    var scaleAmount: Double
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .roundStyle()
             .clipShape(Capsule())
             .overlay(Capsule().stroke(Color.black, lineWidth: 2))
             .shadow(radius: 5)
             .opacity(opacityAmount)
             .scaleEffect(scaleAmount)
             .rotation3DEffect(.degrees(Double(rotateAmount)),
                               axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}
struct ContentView: View   {
    @State private var showingAlert = false
    @State private var countries = ["Estonia", "France",
    "Germany","Ireland", "Italy", "Nigeria", "Poland",
                     "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0;
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var roundNumber = 1;
    @State private var gameOver = false
    @State private var tappedNumber = -1
    @State private var rotateAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    var body: some View {
        ZStack{
            RadialGradient( stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Text("Round \(roundNumber)")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.easeOut(duration: 1)) {
                                rotateAmount += 360
                            }
                            withAnimation() {
                                opacityAmount -= 0.75
                                scaleAmount -= 0.5
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(text: countries[number], rotateAmount: tappedNumber == number ? rotateAmount : 0, opacityAmount: tappedNumber == number ? 1 : opacityAmount, scaleAmount:tappedNumber == number ? 1 : scaleAmount )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
    
            }
            .padding(5)
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)!")
        }
        .alert("Game over", isPresented: $gameOver){
            Button("Start over", action: resetGame)
        } message:{
            Text("Your final score is \(score)!!")
        }
    }
    func flagTapped(_ number: Int){
        tappedNumber = number
        if number == correctAnswer {
            score+=1
            scoreTitle = "Correct +1 points🥳"
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])💩"
        }
        
        if(roundNumber < 8){
            roundNumber += 1
            showingScore = true
        }else{
            gameOver = true
            showingScore = false
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        rotateAmount = 0.0
        scaleAmount = 1.0
        tappedNumber = -1
    }
    func resetGame(){
        score = 0
        gameOver = false
        roundNumber = 1
        askQuestion()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
