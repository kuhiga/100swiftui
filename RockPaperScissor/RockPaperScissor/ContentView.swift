//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Kurt Higa on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    enum Moves: String {
            case ROCK = "🪨"
            case PAPER = "📃"
            case SCISSOR = "✂️"
    }
    let possibleMoves: [Moves] = [.ROCK, .PAPER, .SCISSOR]
    @State private var appMoveIndex = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var roundNumber = 1
    @State private var fighter: Moves = .ROCK
    @State private var feedback = (title: "", message: "")
    @State private var showAlert = false
    @State private var gameOver = false
    
    private var userInput: some View {
        HStack{
            ForEach(possibleMoves, id: \.self){ move in
                Spacer()
                Button{
                    fighter = move
                    playRound(fighter, possibleMoves[appMoveIndex])
                } label: {
                    Text(move.rawValue)
                        .font(.system(size: 80))
                }
                Spacer()
            }
        }
    }
    var body: some View {
        VStack {
            Spacer()
            Text("App chooses \(possibleMoves[appMoveIndex].rawValue), try to \(shouldWin ? "win" : "lose")!")
                .font(.title)
            Text("Round: \(roundNumber)")
                .font(.largeTitle)
                .padding(5)
            Text("score: \(score)")
                .font(.title2)
                .padding(5)
                .foregroundColor(.secondary)
            Spacer()
            userInput
            Spacer()
            Spacer()
        }
        .alert(feedback.title, isPresented: $showAlert){
            Button("Continue", action: nextGame)
        } message: {
            Text(feedback.message)
        }
        .alert("Game over", isPresented: $gameOver){
            Button("Start over", action: resetGame)
        } message:{
            Text("Your final score is \(score)!!")
        }
    }
    func playRound(_ fighter: Moves, _ appFighter: Moves){
        var correctAnswer: Moves
        if shouldWin {
            switch appFighter {
            case Moves.ROCK:
                    correctAnswer = Moves.PAPER
            case Moves.PAPER:
                    correctAnswer = Moves.SCISSOR
            case Moves.SCISSOR:
                    correctAnswer = Moves.ROCK
            }
        } else {
            switch appFighter {
                case Moves.ROCK:
                    correctAnswer = Moves.SCISSOR
                case Moves.PAPER:
                    correctAnswer = Moves.ROCK
                case Moves.SCISSOR:
                    correctAnswer = Moves.PAPER
            }
        }
        if(fighter == correctAnswer){
            score += 1
            feedback.title = "Nice one!"
            feedback.message = "You have \(score) points."
        }else{
            score -= 1
            feedback.title = "Boo!"
            feedback.message = "You have \(score) points."
        }
        if(roundNumber != 10){
            showAlert = true
        }else{
            gameOver = true
        }

    }
    func nextGame(){
        shouldWin = Bool.random()
        appMoveIndex = Int.random(in: 0...2)
        roundNumber += 1
    }
    func resetGame(){
        nextGame()
        roundNumber = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
