//
//  CreateState.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import Combine

class CreateState: ObservableObject {
    
    @Published var title: String = String()
    @Published var content: String = String()
    
    func loadData(id: Int) {
    }
}
