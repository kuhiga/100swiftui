//
//  AstronautView.swift
//  Moonshot
//
//  Created by Kurt Higa on 2/23/24.
//

import Foundation
import SwiftUI

struct AstronautView: View{
    let astronaut: Astronaut
    var body: some View{
        ScrollView{
            VStack{

                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
//                    .clipShape(.capsule)
//                    .overlay(
//                        Capsule()
//                            .strokeBorder(.white, lineWidth:1)
//                    )
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decodeToJSON("astronauts.json")
    return AstronautView(astronaut: astronauts["grissom"]!)
        .preferredColorScheme(.dark)
}
