//
//  MainView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct MainView: View {
    var body: some View {
        TossTabView {
            HomeView()
                .tossTabItem("홈", Image("Home"))
            CommunityView()
                .tossTabItem("커뮤니티", Image("Community"))
            MenuView()
                .tossTabItem("메뉴", Image("Menu"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
