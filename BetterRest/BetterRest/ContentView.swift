//
//  ContentView.swift
//  BetterRest
//
//  Created by Kurt Higa on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    var body: some View {
        NavigationStack{
            VStack{
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeAmount) cup(s)", value: $sleepAmount, in: 1...20)
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button  ("Calculate", action: calculateBedtime  )
            }
        }
//        VStack{
//            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
//                .labelsHidden()
//            Stepper("\(sleepAmount.formatted()) hours", value:  $sleepAmount, in: 4...12, step: 0.25)
//
//            Text(Date.now, format: .dateTime.day().month().year().second())
//            Text(Date.now, format: .dateTime.hour().minute().second())
//            Text(Date.now.formatted(date: .long, time: .complete  ))
//        }
    }
    func calculateBedtime(){
        
    }
    func exampleDates(){
        var tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
    func anotherExampleDates(){
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = now...tomorrow
    }
    func exDate(){
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
//
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
