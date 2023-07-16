//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Oleg Gavashi on 16.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var flags = [("Ukraine", "🇺🇦"), ("Poland", "🇵🇱"), ("UK", "🇬🇧"), ("Germany", "🇩🇪"), ("US", "🇺🇸"), ("Slovakia", "🇸🇰"), ("Japan","🇯🇵"), ("South Korea","🇰🇷") ]
    @State private var answer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var tries = 3
    
    func checkAnswer(_ selected: Int) {
        if answer == selected {
            score += 1
        } else {
            tries -= 1
        }
        
        if score == flags.count {
            alertMessage = "Congratulation!🎉 You won!"
            showAlert = true
            
            return
        }
        
        
        if tries == 0 {
            alertMessage = "Oh no!😥 You lost"
            showAlert = true
            
            return
        }
        
        generateQuestion()
    }
    
    func generateQuestion() {
        answer = Int.random(in: 0...2)
        flags.shuffle()
    }
    
    func resetGame() {
        score = 0
        tries = 3
        generateQuestion()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                VStack(spacing: 5) {
                    Text("Tap the flag of")
                        .font(.title)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(flags[answer].0)
                        .font(.largeTitle.weight(.semibold))
                }
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            checkAnswer(number)
                        } label: {
                            Text(flags[number].1)
                                .font(.system(size: 90))
                        }
                        .padding(.horizontal, 10)
                    }
                }
                Spacer()
                
                Text("Your score: \(score) out of \(flags.count)")
                    .font(.title2)
                    .font(.subheadline.weight(.heavy))
                
                HStack {
                    ForEach(0..<3) { i in
                        Text(i + 1 <= tries ? "💙" : "🖤")
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                Text("Made by OG")
                    .font(.title3.bold())
            }
            .padding()
            .background(.ultraThinMaterial)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("Continue", action: resetGame)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .mint]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
