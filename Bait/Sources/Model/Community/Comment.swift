//
//  Comment.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let name, content: String
    let createDate: Date
}
