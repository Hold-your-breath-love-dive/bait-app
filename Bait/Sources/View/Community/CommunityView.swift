//
//  CommunityView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct CommunityView: View {
    
    @StateObject var state = CommunityState()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TossScrollView("커뮤니티") {
                if let datas = state.datas {
                    LazyVStack(spacing: 10) {
                        ForEach(datas, id: \.self) { data in
                            NavigationLink(destination: WritingView(data: data)) {
                                CommunityCellView(data: data)
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
            .onAppear(perform: state.loadData)
            NavigationLink(destination: CreateView()) {
                Image(systemName: "square.and.pencil")
                    .font(Font.title3.weight(.medium))
                    .frame(height: 40)
                    .foregroundColor(Color(.label))
            }
                .padding(.trailing, 18)
                .offset(y: -5)
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
