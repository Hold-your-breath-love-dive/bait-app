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
        TossScrollView("커뮤니티") {
            
        }
        .background(Color.white.ignoresSafeArea())
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
