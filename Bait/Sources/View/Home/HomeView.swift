//
//  HomeView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct HomeView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var isShowCamera = false
    @State private var isShowSearchView = false
    
    @State private var image = UIImage()
    @State private var result = "First you've to select an image"
    
    @StateObject var state = HomeState()
    
    var body: some View {
        
        TossScrollView("다이브") {
            HStack {
                VStack(alignment: .leading) {
                    Text("7월 12일 · 오늘의 바다 평균수온 22도")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    VStack(spacing: 15) {
                        Image("fish")
                            .padding([.top, .bottom], 10)
                        Text("해양생물을 찍고 찾아보세요!")
                            .font(.system(size: 20, weight: .bold))
                        Text("해양생물을 카메라로 찍거나 갤러리에 있는 물고기 사진을 \n 가져와서 업로드 하시면 어떤 해양생물인지 알려드려요.")
                            .font(.system(size: 14))
                            .lineLimit(2)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    Button(action: {
                        self.isShowCamera = true
                    }) {
                        HomeButtonView("카메라로 찍기")

                    }
                    .disabled(true)
                    .background(Color.white)
                    .cornerRadius(8)
                    .fullScreenCover(isPresented: $isShowCamera) {
                        ImagePickerView(result: self.$result, selectedImage: self.$image, sourceType: .camera)
                            .onDisappear {
                                if !result.isEmpty {
                                    isShowSearchView = true
                                }
                            }
                    }
                    
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        HomeButtonView("갤러리에서 가져오기")

                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .sheet(isPresented: $isShowPhotoLibrary) {
                        ImagePickerView(result: self.$result, selectedImage: self.$image, sourceType: .photoLibrary)
                            .onDisappear {
                                if !result.isEmpty {
                                    isShowSearchView = true
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .background(Color("Background"))
        .fullScreenCover(isPresented: $isShowSearchView) {
            SearchView(isShowingSearchView: $isShowSearchView, selectedImage: image)
        }
    }
}
