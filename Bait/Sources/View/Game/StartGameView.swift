//
//  StartGameView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI

struct StartGameView: View {
    @State private var showGame = false

    var body: some View {
        VStack {
            Text("물고기 잡기 게임에 오신 것을 환영합니다!")
                .font(.title)
                .padding()

            Button("게임 시작") {
                showGame = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $showGame, content: GameView.init)
    }
}
                
