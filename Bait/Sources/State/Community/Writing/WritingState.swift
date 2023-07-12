//
//  WritingState.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import Combine

class WritingState: ObservableObject {
    
    @Published var datas: [Comment]? = nil
    
    func loadData(id: Int) {
        Requests.request("\(API)/comment/\(id)", .get, [Comment].self) { data in
            self.datas = data
        }
    }
}
