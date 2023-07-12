//
//  CreateState.swift
//  Bait
//
//  Created by Mercen on 2023/07/13.
//

import SwiftUI
import PhotosUI

class CreateState: ObservableObject {

    @Published var image: PhotosPickerItem? = nil
    @Published var imageData: Data? = nil
    @Published var title: String = String()
    @Published var name: String = String()
    @Published var password: String = String()
    @Published var content: String = String()
    
    func loadData(id: Int) {
    }
}
