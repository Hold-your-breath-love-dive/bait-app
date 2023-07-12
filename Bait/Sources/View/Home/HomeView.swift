//
//  HomeView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var state = HomeState()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
