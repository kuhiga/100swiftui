import Cocoa

//Arrays
var colors = ["red", "green", "blue"]
colors.append("yellow")
print(colors)
//swift only allows one data type in array
print(colors[0])

var scores = Array<Int>()
scores.append(Int(1.0))

var albums = [String]()
albums.append("Hello")
print(albums.count)
albums.removeAll()

albums.append("zbye")
print(albums.count)
print(albums.contains("zbye"))
albums.append("hi")
print(albums.sorted())

//dictionaries
let employee = [
    "name": "Kurt",
    "job": "software engineer",
    "location": "Earth"
]
print(employee["name"] ?? "bob")
print(employee["names", default: "yo"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
print(heights["Yao Ming", default: 20])

//Sets for fast data look up

let actors = Set([
    "Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel Jackson"]);
print(actors)

var colorSet = Set<String>()
colorSet.insert("red")
colorSet.insert("yellow")
print(colorSet)

//enums
enum Weekend {
    case saturday
    case sunday
}
enum Weekday {
    case monday,
     tuesday,
     wednesday,
     thursday,
     friday
}
print(Weekday.tuesday)

var day = Weekday.friday
print(day)
day = .thursday
print(day)

