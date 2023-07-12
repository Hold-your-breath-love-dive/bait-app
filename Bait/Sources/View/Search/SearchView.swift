//
//  SearchView.swift
//  Bait
//
//  Created by 이민규 on 2023/07/12.
//

import SwiftUI
import OpenTDS
import CoreML
import Vision

struct SearchView: View {
    
    @State var isLoading = true
    @State var scrollViewTitle = "사진을 분석하고 있어요..."
    @State var title = ""
    @State var confidence = ""
    @State var contents = ""
    @Binding var isShowingSearchView: Bool
    
    var selectedImage: UIImage
    
    var body: some View {
        
        TossScrollView(scrollViewTitle) {
            
            if isLoading {
                HStack(alignment: .center) {
                    
                    ProgressView()
                        .frame(width: 86, height: 86)
                        .padding(.top, 240)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 280, height: 300)
                
                VStack {
                    Text("\(title)라는 생물이에요!")
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("AI 정확도 \(confidence)")
                        .font(.system(size: 14, weight: .medium))
                }
                
                VStack {
                    Image("\(title)")
                        .resizable()
                        .frame(width: 124, height: 124)
                        .background(.gray.opacity(0.2))
                    
                    Text("\(contents)")
                        .padding(.horizontal, 20)
                        .onAppear {
                            if let value = fishData["\(title)"] {
                                contents = value
                            } else {
                                contents = "정보가 없습니다"
                            }
                        }
                }
            }
        }
        .showDismiss()
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            
            classifyImage(selectedImage)
        }
        
    }
    func classifyImage(_ image: UIImage) {
        
        guard let cgImage = image.cgImage else {
            print("cgImage로 변하지 않음")
            return
        }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        guard let coreMLModel = try? FishClassifier(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Loading CoreML Model Failed")
        }
        
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            
            if let fitstItem = classification.first {
                title = String(fitstItem.identifier.capitalized.split(separator: "_")[0])
                confidence = String(Int(fitstItem.confidence * 100)) + "%"
                
                if title != "" {
                    scrollViewTitle = "사진과 비슷한 생물을 찾았어요!"
                    isLoading = false
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
        
    }
    
}
