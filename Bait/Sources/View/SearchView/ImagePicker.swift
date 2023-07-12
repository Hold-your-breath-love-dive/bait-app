//
//  ImagePickerModifier.swift
//  Bait
//
//  Created by 이민규 on 2023/07/12.
//

import UIKit
import SwiftUI
import CoreML
import Vision

struct ImagePicker: UIViewControllerRepresentable {

    @Binding1 var result: String
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode)  var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}


final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var parent: ImagePicker

    init(_ parent: ImagePicker) {
        self.parent = parent
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.selectedImage = image
            
            classify(image: image)

        }
 
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    //MARK: The classification part
    func classify(image: UIImage) {
        
        guard let ciImage = CIImage(image: image) else {
            print("Unable to create CIImage")
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let handler = VNImageRequestHandler(ciImage: ciImage)
            do {
            
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification: \(error)")
            }
        }
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
      do {
        
        let model = FishClassifier()
        
        let visionModel = try VNCoreMLModel(for: model.model)
        
        let request = VNCoreMLRequest(model: visionModel, completionHandler: { [weak self] request, error in
          self?.processObservations(for: request, error: error)
        })
        
        request.imageCropAndScaleOption = .centerCrop
        return request
      } catch {
        fatalError("Failed to create VNCoreMLModel: \(error)")
      }
    }()
    
    func processObservations(for request: VNRequest, error: Error?) {
        
        DispatchQueue.main.async {
            
            if let results = request.results as? [VNClassificationObservation] {
                
                if results.isEmpty {
                    self.parent.result = "nothing found"
                    print("nothing found")
                } else if results[0].confidence < 0.8 {
                    self.parent.result = "not sure"
                    print("not sure")
                } else {
                    self.parent.result = String(format: "%@ %.1f%%", results[0].identifier, results[0].confidence * 100)
                    print(String(format: "%@ %.1f%%", results[0].identifier, results[0].confidence * 100))
                }
            } else if let error = error {
                self.parent.result = "error: \(error.localizedDescription)"
            } else {
                self.parent.result = "???"
            }
        }
    }
}
