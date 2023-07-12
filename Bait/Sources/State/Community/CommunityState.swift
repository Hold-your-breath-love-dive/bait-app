//
//  CommunityState.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import Combine

class CommunityState: ObservableObject {
    
    let API: String = "http://127.0.0.1:8080"
    @Published var datas: [Writing]? = nil
    
    func loadData() {
        Requests.request("\(API)/writing/list", .get, [Writing].self) { data in
            self.datas = data
        }
    }
}
