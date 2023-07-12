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
            .font(.system(size: 14, weight: .bold))
    }

    @ViewBuilder func content() -> Text {
        Text(data.content)
            .font(.system(size: 14))
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일 게시"
        return dateFormatter.string(from: data.createDate)
    }
    
    var body: some View {
        HStack {
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
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(title()) \(content())")
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Text("\(formattedDate()) · \(data.commentCount)개의 댓글")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color("Background"))
        .cornerRadius(8)
    }
}
