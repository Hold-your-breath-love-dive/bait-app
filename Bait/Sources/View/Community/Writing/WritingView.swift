//
//  WritingView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct WritingView: View {
    
    let data: Writing
    @Environment(\.dismiss) var dismiss
    @StateObject var state = WritingState()
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "y년 M월 d일 a h시 m분 게시"
        return dateFormatter.string(from: data.createDate)
    }
    
    @ViewBuilder func name() -> Text {
        Text(data.name)
            .font(.system(size: 14, weight: .semibold))
    }

    @ViewBuilder func content() -> Text {
        Text(data.content)
            .font(.system(size: 14))
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                TossScrollView(data.title) {
                    LazyVStack(spacing: 10) {
                        VStack(spacing: 0) {
                            if let image = data.image {
                                Image(uiImage: UIImage(data: Data(base64Encoded: image)!)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: proxy.size.width - 48)
                            }
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\(name()) \(content())")
                                        .multilineTextAlignment(.leading)
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
                            .padding(10)
                            .padding(.horizontal, 3)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(8)
                        if let datas = state.datas {
                            ForEach(datas, id: \.self) { data in
                                WritingCommentView(id: self.data.id, data: data)
                                    .environmentObject(state)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .showDismiss()
                VStack {
                    HStack {
                        TextField("이름", text: $state.name)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(8)
                        SecureField("비밀번호", text: $state.password)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .font(.system(size: 14))
                    HStack {
                        TextField("댓글을 입력하세요.", text: $state.content)
                            .onSubmit {
                                state.write(id: data.id)
                            }
                        Button(action: {
                            state.write(id: data.id)
                        }) {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(state.content.isEmpty
                                                 ? Color(.systemGray4)
                                                 : Color(.label))
                        }
                        .disabled(state.content.isEmpty)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(Color("Background"))
            }
            .navigationBarHidden(true)
            .alert("삭제", isPresented: $state.delete) {
                SecureField("비밀번호", text: $state.enteredPassword)
                Button("승인", action: {
                    state.delete(id: data.id) {
                        dismiss()
                    }
                })
                Button("취소", role: .cancel) {
                    state.enteredPassword = String()
                }
            } message: {
                Text("비밀번호를 입력해 삭제하세요.")
            }
        }
        .onAppear {
            state.loadData(id: data.id)
        }
    }
}
