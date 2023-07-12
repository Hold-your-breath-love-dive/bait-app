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
    
    func write(completion: @escaping () -> Void) {
        var params = ["name": self.name,
                      "password": self.password,
                      "title": self.title,
                      "content": self.content]
        if let imageData = self.imageData {
            let image = UIImage(data: imageData)!.jpegData(compressionQuality: 0.2)!
            params["image"] = image.base64EncodedString()
        }
        Requests.simple("\(API)/writing", .post, params: params) {
            completion()
        }
    }
}
