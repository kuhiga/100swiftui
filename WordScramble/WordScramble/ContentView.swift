//
//  ContentView.swift
//  WordScramble
//
//  Created by Kurt Higa on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    let people = ["Luke", "Anakin", "Yoda", "Obi-wan"]
    var body: some View {
//        List{
//            Section("Section 1"){
//                Text("Static Row 1")
//                Text("Static Row 2")
//            }
//            Section("Section 2"){
//                ForEach(3..<6){
//                    Text("Dynamic Row \($0)")
//                }
//            }
//            Section("Section 3"){
//                Text("Static Row 6")
//                Text("Static Row 7")
//            }
//        }
//        List(0..<5){
//            Text("Dynamic Row \($0)")
//        }
        List(testStrings(), id: \.self){
            Image(systemName: "globe")
            Text($0)
        }
        .listStyle(.grouped)
    }
    func testBundles(){
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let fileContent = try? String(contentsOf: fileURL){
                print(fileContent)
                // we load the file into a string
            }
        }
    }
    func testStrings() -> [String]{
        let input = """
        a
        b
        c
        de
        """
        let letters = input.components(separatedBy: "\n")
        let random = letters.randomElement()
        let trimmed = random?.trimmingCharacters(in: .whitespacesAndNewlines)
        return letters
    }
    
    func testStrings1(){
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in:  word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
