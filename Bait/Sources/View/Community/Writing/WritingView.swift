//
//  WritingView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS
import Kingfisher

struct WritingView: View {
    
    let data: Writing
    @StateObject var state = WritingState()
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "y년 M월 d일 a h시 m분 게시"
        return dateFormatter.string(from: data.createDate)
    }
    
    var body: some View {
        TossScrollView(data.title) {
            LazyVStack(spacing: 10) {
                VStack(spacing: 0) {
                    if let image = data.image {
                        KFImage(URL(string: image)!)
                            .placeholder {
                                Color("Background")
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(height: 195)
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(data.content)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.leading)
                            Text("\(formattedDate())")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .padding(.horizontal, 3)
                .background(Color("Background"))
                .cornerRadius(8)
                if let datas = state.datas {
                    ForEach(datas, id: \.self) { data in
                        WritingCommentView(data: data)
                            .environmentObject(state)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
        .showDismiss()
        .navigationBarHidden(true)
        .onAppear {
            state.loadData(id: data.id)
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
