//
//  SearchView.swift
//  Bait
//
//  Created by 이민규 on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct SearchView: View {
    
    @Binding var isShowingSearchView: Bool
    
    var selectedImage: UIImage
    
    var title: String = "검색"
    
    var body: some View {
        
        TossScrollView("\(title)") {
            
            Image(uiImage: selectedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        }
        .showDismiss()
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            print(selectedImage.size)
        }
    }
}
