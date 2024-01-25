import Cocoa

var greeting = "Hello, playground"

var surname: String = "Higa"

let luckyNumber: Int = 7
let pi: Double = 3.14
var albums: [String] = ["hello"]
var users: [String: String] = ["id": "@twostraws", "ds": "Asd"]
var books: Set<String> = Set([
"helo", "hello", "hey   "])

var teams: [String] = [String]()
var clues = [String]()

enum UIStyle {
    case light, dark, system
}
var style = UIStyle.light
style = .dark

//checkpoint 2

let names: [String] = ["Bob", "Joe", "Taro", "Bob", "Hamilton"]
print(names.count)
print(Set(names).count)
