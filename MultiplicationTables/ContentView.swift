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
struct Question {
    var question = ""
    var answer = 0
}

struct ContentView: View {
    @State private var showSettings = true
    
    @State private var timesTable = 2
    @State private var totalQuestions = 5
    @State private var difficulty = "easy"
    @State private var questions = [Question]()
    
    @State private var currentQuestion = 0
    @State private var answer = 0
    @State private var correct = 0
    @FocusState private var answerFocused: Bool
    
    @State private var showingSubmission = false
    @State private var submissionTitle = ""
    @State private var submissionMessage = ""
    
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
        else if currentQuestion < totalQuestions{
            NavigationView{
                List{
                    ForEach(0..<questions.count, id: \.self) { i in
                        if i == currentQuestion {
                            Text(questions[i].question)
                        }
                    }
                    Section{
                        TextField("Answer", value: $answer, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($answerFocused)
                    }
                    
                    
                }
                .navigationTitle("Multiply")
                .onAppear(perform: generateQuestions)
                .toolbar {
                    Button("Settings"){
                        resetGame()
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Submit"){
                            answerFocused = false
                            checkAnswer()
                        }
                    }
                }
                .alert(submissionTitle, isPresented: $showingSubmission){
                    Button("OK", role: .cancel){
                        currentQuestion += 1
                    }
                } message: {
                    Text(submissionMessage)
                }
            }
        }
        else{
            NavigationView{
                VStack{
                    Text("Times Tables up to: \(timesTable)")
                    Text("Difficulty: " + difficulty)
                    Text("Total Questions: \(questions.count)")
                    Text("Correct: \(correct)")
                    Button("Continue"){
                        resetGame()
                    }
                    .padding()
                    .clipped()
                    .background(.red)
                    .foregroundColor(.white)
                }
                .navigationTitle("COMPLETE")
            }
        }
    }
    func resetGame() {
        showSettings = true
        currentQuestion = 0
        answer = 0
        correct = 0
    }
    
    func checkAnswer(){
        showingSubmission = true
        if answer == questions[currentQuestion].answer {
            correct += 1
            submissionTitle = "CORRECT"
            submissionMessage = questions[currentQuestion].question + "= \(questions[currentQuestion].answer)"
        }
        else{
            submissionTitle = "WRONG"
            submissionMessage = questions[currentQuestion].question + "= \(questions[currentQuestion].answer)"
        }
    }
    
    func generateQuestions() {
        questions = [Question]()
        var rand1: Int
        var rand2: Int
        var easyRange = (1...10)
        var hardRange = (10...100)
        
        switch difficulty{
        case "easy":
            for _ in (0..<totalQuestions) {
                var tempQuestion = Question()
                rand1 = Int.random(in: 2...timesTable)
                rand2 = Int.random(in: easyRange)
                tempQuestion.question = "\(rand1) * \(rand2)"
                tempQuestion.answer = rand1 * rand2
                questions.append(tempQuestion)
            }
        case "hard":
            for _ in (0..<totalQuestions) {
                var tempQuestion = Question()
                rand1 = Int.random(in: 2...timesTable)
                rand2 = Int.random(in: 10...100)
                tempQuestion.question = "\(rand1) * \(rand2)"
                tempQuestion.answer = rand1 * rand2
                questions.append(tempQuestion)
            }
        default:
            var error = Question()
            error.question = "ERROR: no questions for this difficulty"
            questions.append(error)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
