//
//  WritingCommentState.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import Combine

class WritingCommentState: ObservableObject {
    
    @Published var delete: Bool = false
    @Published var enteredPassword: String = String()
    
    func delete(id: Int, completion: @escaping () -> Void) {
        Requests.simple("\(API)/comment/\(id)", .delete,
                        params: ["password": self.enteredPassword]) {
            completion()
        }
    }
}
