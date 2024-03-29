//
//  ContentView.swift
//  BetterRest
//
//  Created by Kurt Higa on 1/31/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var calculatedBedtime: String{
        var message: String
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            message = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch {
            message = "Sorry, there was a problem calculating your bedtime."
        }
        return message
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("When do you want to wake up?"){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.headerProminence(.increased)
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0){
                    
//                    Text("Daily coffee intake")
//                        .font(.headline)
                    Picker("Daily coffee intake", selection: $coffeeAmount){
                        ForEach(1...20, id: \.self) { number in
                            Text("^[\(number) cup](inflect: true)")
                        }
                    }
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
                Section("Recommended bedtime"){
                    Text("\(calculatedBedtime)")
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button  ("Calculate", action: calculateBedtime  )
//            }
//            .alert(alertTitle, isPresented: $showingAlert){
//                Button("OK"){}
//            }message: {
//                Text(alertMessage)
//            }
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
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
    func exampleDates(){
        let tomorrow = Date.now.addingTimeInterval(86400)
        let _ = Date.now...tomorrow
    }
    func anotherExampleDates(){
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let _ = now...tomorrow
    }
    func exDate(){
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
//
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let _ = components.hour ?? 0
        let _ = components.minute ?? 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
