//
//  CreateView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import PhotosUI
import OpenTDS

struct CreateView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var state = CreateState()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TossScrollView("글쓰기") {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                TextField("이름", text: $state.name)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("Background"))
                                    .cornerRadius(8)
                                SecureField("비밀번호", text: $state.password)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("Background"))
                                    .cornerRadius(8)
                            }
                            .font(.system(size: 14))
                            TextField("제목을 입력하세요.", text: $state.title)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color("Background"))
                                .cornerRadius(8)
                        }
                        if let image = state.imageData,
                           let uiImage = UIImage(data: image) {
                            Button(action: {
                                state.image = nil
                                state.imageData = nil
                            }) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 65, height: 65)
                                    .cornerRadius(8)
                            }
                        } else {
                            PhotosPicker(
                                selection: $state.image,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .foregroundColor(Color(.label))
                                }
                                .onChange(of: state.image) { newItem in
                                    Task {
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            state.imageData = data
                                        }
                                    }
                                }
                                .frame(width: 65, height: 65)
                                .background(Color("Background"))
                                .cornerRadius(8)
                        }
                    }
                    TextField("본문을 입력하세요.", text: $state.content, axis: .vertical)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .lineLimit(5...100)
                        .background(Color("Background"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 24)
            }
            .showDismiss()
            Button(action: {
                state.write {
                    dismiss()
                }
            }) {
                Text("완료")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(height: 40)
                    .foregroundColor(Color(.label))
            }
                .padding(.trailing, 18)
                .offset(y: -4)
        }
        .navigationBarHidden(true)
    }
}
