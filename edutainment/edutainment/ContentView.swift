//
//  ContentView.swift
//  edutainment
//
//  Created by Kurt Higa on 2/11/24.
//

import SwiftUI

struct ContentView: View {
    // 2 ~ 12
    @State private var chosenTable: Int = 2
    @State private var chosenQuestionCount = 5
    @State private var questionCountOptions = [5, 10, 20]
    @State private var multiplier = 1
    @State private var roundNumber = 1
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @FocusState private var answerIsFocused: Bool
    func startGame(){
        showingAlert = false
        alertTitle = ""
        alertMessage = ""
        answerIsFocused = false
        score = 0
        roundNumber = 1
        userAnswer = ""
        multiplier = Int.random(in: 1...12)
    }
    
    func answerQuestion(){
        answerIsFocused = false
        let correctAnswer = multiplier * chosenTable
        if(Int(userAnswer) == correctAnswer){
            score += 1
        }
        nextRound()
    }
    
    func nextRound(){
        if(roundNumber == chosenQuestionCount){
            alertTitle = "Game over!"
            alertMessage = "You got \(score) out of \(chosenQuestionCount) answers correct!"
            showingAlert = true
        }
        roundNumber += 1
        userAnswer = ""
        multiplier = Int.random(in: 1...12)
    }
    var body: some View {
        NavigationStack {
                Form{
                    Section("Select a table you want to practice."){
                        Picker("Table Number", selection: $chosenTable){
                            ForEach(2...12, id: \.self){ number in
                                Text("\(number)")
                            }
                        }
                        .onChange(of: chosenTable){ _ in
                            startGame()
                        }
                    }
                    Section("Choose the number of questions you want."){
                        Picker("Table Number", selection: $chosenQuestionCount){
                            ForEach(questionCountOptions, id: \.self){ count in
                                Text("\(count)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section{
                        Text("What is \(chosenTable) x \(multiplier)")
                        HStack{
                            TextField("Enter your answer", text: $userAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.trailing)
                                .keyboardType(.numberPad)
                                .focused($answerIsFocused)
                                .onSubmit(answerQuestion)
                            Spacer()
                            Button("Submit"){
                                if(userAnswer != ""){
                                    answerQuestion()
                                }
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .padding(10)
                }
                .toolbar{
                    Button("Reset game"){
                        startGame()
                    }
                }
            Section{
                Text("Score: \(score)")
            }
            .padding(20)
        }
        .navigationTitle("Edutainment")
        .alert(alertTitle, isPresented: $showingAlert){
            Button("Ok"){
                startGame()
            }
        } message: {
            Text(alertMessage)
        }
        .onAppear(perform: startGame)
        .ignoresSafeArea()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
