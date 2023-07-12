//
//  HomeButtonView.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import SwiftUI

struct HomeButtonView: View {
    var title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text("\(title)")
                .foregroundColor(Color.black)
                .font(.system(size: 18, weight: .semibold))
            
            Spacer()
            
            Image("RightArrow")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
    
}
