//
//  Writing.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import Foundation

struct Writing: Codable, Hashable {
    let id, commentCount: Int
    let name, title, content: String
    let createDate: Date
    let modified: Bool
    let image: String?
}
