//
//  WritingCommentView.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import SwiftUI

struct WritingCommentView: View {
    
    @EnvironmentObject var envState: WritingState
    @StateObject var state = WritingCommentState()
    let id: Int
    let data: Comment

    @ViewBuilder func name() -> Text {
        Text(data.name)
            .font(.system(size: 14, weight: .semibold))
    }

    @ViewBuilder func content() -> Text {
        Text(data.content)
            .font(.system(size: 14))
    }
    
    func formattedDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.localizedString(for: data.createDate, relativeTo: Date())
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(name()) \(content())")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(.label))
                HStack {
                    Text("\(formattedDate())")
                        .font(.system(size: 14))
                    Spacer()
                    Button(action: {
                        state.delete.toggle()
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }
                    .offset(x: 7)
                }
                .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 3)
        .background(Color("Background"))
        .cornerRadius(8)
        .alert("삭제", isPresented: $state.delete) {
            SecureField("비밀번호", text: $state.enteredPassword)
            Button("승인", action: {
                state.delete(id: data.id) {
                    envState.loadData(id: id)
                }
            })
            Button("취소", role: .cancel) {
                state.enteredPassword = String()
            }
        } message: {
            Text("비밀번호를 입력해 삭제하세요.")
        }
    }
}
