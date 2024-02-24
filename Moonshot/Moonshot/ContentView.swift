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

    let columns   = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(missions){ mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                    .padding()
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))

                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10 ))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                                )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
                  .foregroundStyle(.white)
            .background(.darkBackground)
            .preferredColorScheme(.dark  )
        }
    }
}

#Preview {
    ContentView()
}
