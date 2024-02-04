//
//  ContentView.swift
//  WordScramble
//
//  Created by Kurt Higa on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        NavigationStack{
            VStack{
                Grid{
                    Text("Score: \(score)")
                    List {
                        Section{
                            TextField("Enter your word", text: $newWord)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                        }
                        Section{
                            ForEach(usedWords, id: \.self){ word in
                                HStack{
                                    Image(systemName: "\(word.count).circle")
                                    Text(word)
                                }
                            }
                        }
                    }
                    .padding(30)
                    .navigationTitle(rootWord)
                    .onSubmit(addNewWord)
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError){
                        Button("Ok"){
                            newWord = ""
                        }
                    } message: {
                        Text(errorMessage)
                    }
                    .toolbar{
                        Button("Shuffle word"){
                            usedWords = []
                            score = 0
                            startGame()
                        }
                    }
                }
                .padding(5)
                }
        }
    }
    //func add new word: lower case wword and remove white strings
    func addNewWord(){
        let formattedNewWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard formattedNewWord.count > 0 else { return }
        
        guard isOriginal(word: formattedNewWord) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossibleWord(word: formattedNewWord) else {
            wordError(title: "Word is not possible ", message: "You can't spell that word from '\(rootWord)'")
            return
        }
        guard isRealWord(word: formattedNewWord) else {
            wordError(title: "'\(formattedNewWord)' is not a real word", message: "Read a dictionary!")
            return
        }
        guard isLongEnough(word: formattedNewWord) else {
            wordError(title: "Word is too short", message: "It must be atleast 2 characters long!")
            return
        }
        withAnimation{
            usedWords.insert(formattedNewWord, at: 0)
        }
        score += formattedNewWord.count
        newWord = ""
    }
    func startGame(){
        if let startWordsURL =  Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf:  startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load \"start.txt\" from bundle.")
    }
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word) && rootWord != word
    }
    func isLongEnough(word: String) -> Bool{
        return word.count > 1
    }
    func isPossibleWord(word: String) -> Bool{
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    func isRealWord(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in:  word, range: range, startingAt: 0, wrap: false, language: "en")
        let isNotMispelled = misspelledRange.location == NSNotFound
        return isNotMispelled
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
