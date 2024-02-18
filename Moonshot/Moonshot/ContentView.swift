//
//  ContentView.swift
//  Moonshot
//
//  Created by Kurt Higa on 2/17/24.
//

import SwiftUI

struct CustomText: View{
    let text: String
    var body: some View{
          Text(text)
    }
    init(text: String  ) {
        print("creating a custom text ")
        self.text = text
    }
}

struct Address: Codable{
    let street: String
    let country: String
}

struct User: Codable{
    let name: String
    let address: Address
}

struct ContentView: View {
    let astronauts: [String: Astronaut ] = Bundle.main.decodeToJSON("astronauts.json")
    let missions: [Mission] = Bundle.main.decodeToJSON("missions.json")

    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: layout){
                ForEach(0..<99 ){
                     Text("Item \($0 )")
                }
            }
        }
//        Button("Decode JSON"){
//            let input = """
//            {
//                "name": "Kurt Higa",
//                "address": {  
//                    "street": "123 st",
//                    "country": "USA"
//                }
//            }
//            """
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data){
//                print(user.address.street)
//            }
//        }
    }
}

#Preview {
    ContentView()
}
