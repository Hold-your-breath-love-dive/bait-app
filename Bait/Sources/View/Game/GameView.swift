//
//  GameView.swift
//  Bait
//
//  Created by 최시훈 on 2023/07/13.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var score = 0
    @State private var timeRemaining = 10
    @State private var showAlert = false
    @State private var fishes = [Fish]()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let newFishTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Time: \(timeRemaining)")
                .font(.headline)
                .padding()

            VStack {
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()

                ZStack {
                    ForEach(fishes.indices, id: \.self) { index in
                        Image(fishes[index].imageName)
                            .resizable()
                            .frame(width: fishes[index].size, height: fishes[index].size)
                            .position(fishes[index].position)
                            .animation(.easeInOut)
                            .transition(.slide)
                            .onAppear {
                                startFishMovement(index)
                            }
                    }
                }
                .onTapGesture {
                    self.tappedFish()
                }
            }

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("Final Score: \(score)"),
                primaryButton: .default(Text("Play Again"), action: restartGame),
                secondaryButton: .default(Text("Exit"), action: {
                    dismiss()
                })
            )
        }
        .onAppear(perform: startGame)
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endGame()
            }
        }
        .onReceive(newFishTimer) { _ in
            addNewFish()
        }
    }

    func startGame() {
        score = 0
        timeRemaining = 10
        resetFishPositions()
    }

    func endGame() {
        showAlert = true
    }

    func restartGame() {
        startGame()
    }

    func tappedFish() {
        if let index = fishes.indices.randomElement() {
            fishes.remove(at: index)
            score += 1
        }
    }
    func resetFishPositions() {
        fishes = [
            Fish(imageName: "fish", position: randomPosition(), size: 80),
            Fish(imageName: "fish", position: randomPosition(), size: 80),
            Fish(imageName: "fish", position: randomPosition(), size: 80)
        ]
    }

    func startFishMovement(_ index: Int) {
        guard index >= 0 && index < fishes.count else {
            return
        }
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var count = 0

        fishes[index].position = randomPosition() // Initial random position

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if count < 100 { // Move fish for 5 seconds
                if index >= 0 && index < fishes.count {
                    fishes[index].position = randomPosition()
                    count += 1
                }
            } else {
                timer.invalidate()
            }
        }
    }

    func randomPosition() -> CGPoint {
        let minX: CGFloat = 50
        let minY: CGFloat = 100
        let maxX = UIScreen.main.bounds.width - 50
        let maxY = UIScreen.main.bounds.height - 100

        let randomX = CGFloat.random(in: minX...maxX)
        let randomY = CGFloat.random(in: minY...maxY)

        return CGPoint(x: randomX, y: randomY)
    }

    func addNewFish() {
        let newFish = Fish(imageName: "fish", position: randomPosition(), size: 80)
        fishes.append(newFish)
    }
}

struct Fish: Identifiable {
    let id = UUID()
    let imageName: String
    var position: CGPoint
    var size: CGFloat
}
