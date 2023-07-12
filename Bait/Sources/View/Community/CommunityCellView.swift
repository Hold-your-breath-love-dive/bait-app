//
//  CommunityCellView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import Kingfisher

struct CommunityCellView: View {
    
    let data: Writing

    @ViewBuilder func title() -> Text {
        Text(data.title)
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
        VStack(spacing: 0) {
            if let image = data.image {
                KFImage(URL(string: image)!)
                    .placeholder {
                        Color("Background")
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 195)
            }
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(title()) \(content())")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(.label))
                    Text("\(formattedDate()) · \(data.commentCount)개의 댓글")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 3)
        .background(Color("Background"))
        .cornerRadius(8)
    }
}
