//
//  WritingCommentView.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import SwiftUI

struct WritingCommentView: View {
    
    @EnvironmentObject var state: WritingState
    let data: Comment

    @ViewBuilder func name() -> Text {
        Text(data.name)
            .font(.system(size: 14, weight: .semibold))
    }

    @ViewBuilder func content() -> Text {
        Text(data.content)
            .font(.system(size: 14))
    }
    
    func formattedDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.localizedString(for: data.createDate, relativeTo: Date())
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(name()) \(content())")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(.label))
                Text(formattedDate())
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 3)
        .background(Color("Background"))
        .cornerRadius(8)
    }
}
