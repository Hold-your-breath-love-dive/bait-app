//
//  WritingState.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI

class WritingState: ObservableObject {
    
    @Published var datas: [Comment]? = nil
    @Published var name: String = String()
    @Published var password: String = String()
    @Published var content: String = String()
    
    func loadData(id: Int) {
        datas = nil
        Requests.request("\(API)/comment/\(id)", .get, [Comment].self) { data in
            self.datas = data
            print(data)
        }
    }
    
    func write(id: Int) {
        let params = ["name": self.name,
                      "password": self.password,
                      "content": self.content]
        Requests.simple("\(API)/comment/\(id)", .post, params: params) {
            self.loadData(id: id)
        }
    }
}
