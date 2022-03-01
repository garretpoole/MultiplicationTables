//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Garret Poole on 2/28/22.
//

import SwiftUI

//struct Settings: View{
//    @State private var timesTable = 2
//    @State private var totalQuestions = 5
//    @State private var difficulty = ""
//
//    let possibleQuestions = [5, 10, 15, 20]
//    let difficulties = ["easy", "hard"]
//    var body: some View{
//        NavigationView{
//            Form{
//                Section("Select Tables"){
//                    Stepper("Tables up to...\(timesTable.formatted())", value: $timesTable, in: 2...12)
//                }
//                Section("Total Questions"){
//                    Picker("Number of Questions", selection: $totalQuestions){
//                        ForEach(possibleQuestions, id: \.self){
//                            Text("\($0)")
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                Section("Difficulty"){
//                    Picker("Difficulty", selection: $difficulty){
//                        ForEach(difficulties, id: \.self){
//                            Text($0)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//            }
//            .navigationTitle("Settings")
//        }
//    }
//}

struct ContentView: View {
    @State private var showSettings = true
    
    @State private var timesTable = 2
    @State private var totalQuestions = 5
    @State private var difficulty = "easy"
    
    let possibleQuestions = [5, 10, 15, 20]
    let difficulties = ["easy", "hard"]
    var body: some View{
        if showSettings{
            NavigationView{
                Form{
                    Section("Select Tables"){
                        Stepper("Tables up to...\(timesTable.formatted())", value: $timesTable, in: 2...12)
                    }
                    Section("Total Questions"){
                        Picker("Number of Questions", selection: $totalQuestions){
                            ForEach(possibleQuestions, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section("Difficulty"){
                        Picker("Difficulty", selection: $difficulty){
                            ForEach(difficulties, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Button("Confirm"){
                        showSettings = false
                    }
                }
                .navigationTitle("Settings")
            }
        }
        else{
            NavigationView{
                VStack{
                    
                }
                .navigationTitle("Multiply")
                .toolbar {
                    Button("Settings"){
                        showSettings = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
