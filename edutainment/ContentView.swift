//
//  ContentView.swift
//  edutainment
//
//  Created by Myan Patel on 30/05/2022.
//

// Committing new changes to GitHub.
import SwiftUI

struct ContentView: View {
    
    // Create properties here
    @State private var questionSelect = 5
    
    let questionSelection = [5, 10, 20]
    
    @State private var timetableSelect = 2
    
    @State private var gameState = false
    
    @State private var answer = ""
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var runs = 1
    
    @State private var questionTitle = ""
    @State private var questionDict = [String: Int]()
    @State private var gameOver = false
    
    @State private var score = 0
    
    var body: some View {
        
        NavigationView {
            
            List {
                // Section 1: User determines how many questions they want to be asked
                Section{
                    Picker("Number of Questions", selection: $questionSelect){
                        
                        ForEach(questionSelection, id:\.self){
                            Text(String($0))
                        }
                        
                        
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How many questions?")
                    
                }
                
                // Section 2: User picks which times table they want to be questioned on
                Section{
                    VStack{
                        Stepper("Select Times Table", value: $timetableSelect, in: 2...12)
                        Text("\(timetableSelect) times table")
                    }
                    
                  
                    
                    Button(gameState ? "Stop Quiz" : "Start Quiz"){
                        
                        gameState.toggle()
                        
                        
                        if gameState{
                        
                            startQuiz()
                            setQuestion()
                            
                        }
                    
                        
                    }
                    
                }
                
                // Section 3: User can now start answering questions
                if gameState {
                    Section{
                        VStack{
                            Text("Question \(runs): \(questionTitle)")
                            TextField("Enter your answer here", text: $answer)
                            Button("Check Answer"){
                                checkAnswer()
                            }
                            Text("Score: \(score)")
                        }
                    }
                }
                
                
                
            }.navigationTitle("edutainment")
                .alert(scoreTitle, isPresented: $showingScore){
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your Score is \(score) out of \(questionSelect)")
                }.alert("Quiz Complete!", isPresented: $gameOver){
                    Button("Play Again", action: reset)
                } message: {
                    Text("Your Score is \(score) out of \(questionSelect)")
                }
            
        }
        
    }
    
    // Create functions here
    
    func setQuestion(){
        
        let myQuiz = Question(multipleChoice: timetableSelect)
        let questions = myQuiz.generateQuestions()
        self.questionDict = questions
        
        let randomQuestion = questions.randomElement()!.key
       
        questionTitle = randomQuestion
        
    }
    
    func askQuestion(){
        
        if runs <= questionSelect {
            answer = ""
            let randomQuestion = self.questionDict.randomElement()!.key
            questionTitle = randomQuestion
            
        } else {
            gameOver = true
        }
       
        
        
    }
    
    func checkAnswer() {
        
        if Int(answer) == questionDict[questionTitle]{
            runs += 1
            showingScore = true
            scoreTitle = "Correct!"
            score += 1
        } else {
            runs += 1
            scoreTitle = "Incorrect... try again!"
        }
        
        showingScore = true
        
    }
    
    func reset(){
        
        score = 0
        runs = 1
        answer = ""
        gameState = false
        
    }
    
    func startQuiz(){
        score = 0
        runs = 1
        answer = ""
    }
    
    // Create Structs here
    
    struct Question {
        
        //var questionAmount: Int
        var multipleChoice: Int
        
        
        func generateQuestions() -> [String:Int] {
            
            var questions = [String: Int]()
            
            for number in 1...12 {
                
                let question = "\(number) x \(multipleChoice)"
                questions[question] = number * multipleChoice
            }
            
            return questions
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
