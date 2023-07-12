//
//  MenuView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject var state = MenuState()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
