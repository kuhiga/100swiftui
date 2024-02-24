//
//  ContentView.swift
//  Navigation
//
//  Created by Kurt Higa on 2/23/24.
//

import SwiftUI
  
@Observable
class PathStore{
    var path: NavigationPath{
        didSet{
            save()
        }
    }
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init(){
        if let data = try?   Data(contentsOf: savePath){
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data){
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    func save(){
        guard let representation = path.codable else { return }
        do{
            let data = try JSONEncoder().encode(representation )
            try data.write(to: savePath)
        }catch{
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    //The @Binding property wrapper lets us pass an @State property into another view and modify it from there
    @Binding var path: NavigationPath
    var body: some View {
        NavigationLink("Go to random number", value: Int.random(in:  1...1000 ))
            .navigationTitle("Number: \(number)")
            .toolbar{
                Button("Home"){
                    path = NavigationPath()
                }
            }
    }
}
struct ContentView: View {
    @State private var pathStore = PathStore()
//    @State private var path = NavigationPath()
    var body: some View  {
        NavigationStack(path: $pathStore.path){
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path   )
                }
        }
//    @State private var path = NavigationPath()
//    var body: some View{
//        NavigationStack(path: $path){
//            List{
//                ForEach(0..<5){ i in
//                    NavigationLink("Select number: \(i)", value: i)
//                }
//                ForEach(0..<5){ i in
//                    NavigationLink("Select string: \(i)", value: String(i))
//                }
//            }
//            .toolbar{
//                Button("Push 556"){
//                    path.append(556)
//                }
//                Button("Push Hello"){
//                    path.append("Hello")
//                }
//            }
//            .navigationDestination(for: Int.self){ selection in
//                Text("You selected \(selection)")
//            }
//            .navigationDestination(for: String.self){ selection in
//                Text("You selected \(selection)")
//            }
//        }
    
//    @State private var path = [Int]()
//    var body: some View {
//        NavigationStack(path: $path){
//            VStack{
//                //more code to come
//                Button("32"){
//                    path = [32]
//                }
//                Button("64"){
//                    path.append(64 )
//                }
//                Button("Show 32 then 64"){
//                    path = [32,64]
//                }
//            }
//            .navigationDestination(for: Int.self){ selection in
//                    Text("You selected \(selection)")
//            }
//        }
    
//        NavigationStack{
//            List(0..<100){ i in
//                NavigationLink("select \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self){ selection in
//                  Text("You selected \(selection  )")
//            }
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
