//
//  CreateView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct CreateView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var state = CreateState()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            TossScrollView("글쓰기") {
                
            }
            .showDismiss()
            Button(action: {
                dismiss()
            }) {
                Text("완료")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(height: 40)
                    .foregroundColor(Color(.label))
            }
                .padding(.trailing, 18)
                .offset(y: -4)
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
